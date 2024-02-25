import logging
import apache_beam as beam

from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.gcp.bigquery import WriteToBigQuery


class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_argument(
            '--input',
            default='gs://gcp_practice_95/data_sample.csv',
            type=str,
            required=False,
            help='Input csv file to read.')

        parser.add_argument(
            '--project_id',
            default='project1',
            type=str,
            required=False,
            help='provide project')
        
        parser.add_argument(
            '--dataset_id',
            default='dataset1',
            type=str,
            required=False,
            help='provide dataset_id')
        
        parser.add_argument(
            '--table_id',
            default='table1',
            type=str,
            required=False,
            help='provide table_id')

        parser.add_argument(
            '--batch_size',
            default=10,
            type=int,
            required=False,
            help='provide size of baatch')
        
        parser.add_argument(
            '--schema',
            default="schema1",
            type=str,
            required=False,
            help='provide schema')


class validateRows(beam.DoFn):

    def __init__(self,schema):
        self.schema = schema
        
    def process(self, batch):

        valid_rows = []
        for element in batch:
            validated_row = self.validate_schema(element)
            if validated_row:
                # logging.info(f"validated row: {validated_row}")
                valid_rows.append(validated_row)
                # yield validated_row
        
        yield valid_rows


    def validate_schema(self, row):
        # Validate each row against the specified schema
        # You might need to customize this based on your actual schema
        table_schema = self.schema.get().split(";")
        # logging.info(f"table_schema : {table_schema}")
        if len(row) == len(table_schema):
            json_row = {field: value for field, value in zip(table_schema, row)}
            if json_row['store_and_fwd_flag'] == 'Y':
                json_row['store_and_fwd_flag'] = True
            else: 
                json_row['store_and_fwd_flag'] = False
            return json_row

        else:
            # Log or handle invalid rows
            logging.info(f"Invalid row: {row}")


class writeToBQ(beam.DoFn):

    def __init__(self,table_id,project_id):
        logging.info(f"in initial")
        self.table = table_id
        self.project_id = project_id

    def start_bundle(self):
        logging.info(f"in start bundle")
        from google.cloud import bigquery
        self.client = bigquery.Client(project=self.project_id.get())

    def process(self,element):

        logging.info(f"len of element: {len(element)}")
        # logging.info(f"element: {element}")

        errors = self.client.insert_rows_json(self.table.get(), element)  # Make an API request.
        if errors == []:
            logging.info("New rows have been added.")
        else:
            logging.info("Encountered errors while inserting rows: {}".format(errors))


def gcs_to_bq_pipeline():

    try:
        myoptions = PipelineOptions().view_as(MyOptions)
        p = beam.Pipeline(options=myoptions)


        input_data = (
                p
                | "Read input data" >> beam.io.ReadFromText(myoptions.input,skip_header_lines=1)
                | "Parse CSV" >> beam.Map(lambda line: line.split(","))
        )

        batch_rows = input_data | "Batch elements" >> beam.BatchElements(min_batch_size=1000, max_batch_size=10000)


        bq_rows = (
            batch_rows
            | 'validate row' >> beam.ParDo(validateRows(myoptions.schema))
        )


        # bq_rows | "WriteToBigQuery" >> WriteToBigQuery(
        #                 table=myoptions.table_id,
        #                 schema=table_schema,
        #                 create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
        #                 write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND,
        #                 method="STREAMING_INSERTS"
        #             )  

        bq_rows | "write to bq table" >> beam.ParDo(writeToBQ(myoptions.table_id,myoptions.project_id))

        p.run().wait_until_finish()

    except Exception as e_msg:
        print(f"exception at line {e_msg.__traceback__.tb_lineno}:{e_msg}")


if __name__ == "__main__":
    gcs_to_bq_pipeline()
