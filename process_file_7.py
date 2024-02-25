import apache_beam as beam
from apache_beam import pvalue
import logging
import re
from apache_beam.io import WriteToText
from apache_beam.options.pipeline_options import PipelineOptions
import csv

logging.getLogger().setLevel(logging.INFO)



class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):

        parser.add_value_provider_argument(
            '--project_id',
            default='spiritual-clock-410718',
            type=str,
            required=False,
            help="GCP Project to run the Dataflow Job"
        )

        parser.add_value_provider_argument(
            '--working_region',
            default='us-central1',
            type=str,
            required=False,
            help='Input csv file to read.')

        parser.add_value_provider_argument(
            '--input_file_path',
            default='gs://iris-gcp-cstudy/Input_data/input.csv',
            type=str,
            required=False,
            help='Input csv file to read.')
        
        parser.add_value_provider_argument(
            '--enrichment_response_file_path',
            default='gs://iris-cstudy-output/enrichment_response.csv',
            type=str,
            required=False,
            help='Input csv file to read.'
        )

        parser.add_value_provider_argument(
            '--status_response_file_path',
            default='gs://iris-cstudy-output/status_response.csv',
            type=str,
            required=False,
            help='Input csv file to read.'
        )
        

class ProcessHeaderFn(beam.DoFn):
    def process(self, element):
        column_names = element.split(',')
        logging.info("#"*150)
        logging.info("Vinod Column names are: %s", column_names)
        logging.info("#"*150)
        column_names = [column.strip() for column in column_names]
        logging.info("Vinod Column names after clean up: %s", column_names)
        logging.info("#"*150)
        yield column_names

class ValidateAndTransform(beam.DoFn):
    def is_valid_lei(self, lei):
        return bool(re.match(r'^[A-Z0-9]{1,20}$', lei))

    def process(self, element, col_names, unique_transaction_ids):
        ISIN = ' Security identifier'
        LEI = ['Reporting Counterparty Code', 'Non-Reporting Counterparty Code']
        DATE = [' Event date', ' Value date', ' Loan Maturity of the security']
        MANDATORY_FIELDS = ['Transaction ID', 'Reporting Counterparty Code', 'Non-Reporting Counterparty Code', ' Security identifier']
        ENRICHMENT_COLUMNS = ['Type of asset', 'Security identifier', ' Classification of a security',
                      ' Loan Base product', ' Loan Sub product', ' Loan Further sub product',
                      'Loan LEI of the issuer', ' Loan Maturity of the security', ' Loan Jurisdiction of the issuer ']

        logging.info("vinod Processing data: %s", element)
        logging.info("#"*150)
        column_names = col_names[0]        
        mapped_data = {column_names[i]: value for i, value in enumerate(element.split(','))}
        logging.info("vinod Mapped data: %s", mapped_data)
        logging.info("#"*150)
        status = "ACCPTD"
        for field in ['Type of asset', 'Security identifier', 'Classification of a security',
                      'Loan Base product', 'Loan Sub product', 'Loan Further sub product',
                      'Loan LEI of the issuer', 'Loan Maturity of the security', 'Loan Jurisdiction of the issuer']:
            if not mapped_data.get(field) or mapped_data.get(field).strip() == '':
                logging.error("vinod Missing or empty value for mandatory field: %s", field)
                status = " RJCT"

        for date_field in ['Event date', 'Value date', 'Loan Maturity of the security']:
            if not mapped_data.get(date_field) and not mapped_data.get(field).strip() != '':
                try:
                    new_date = datetime.strptime(mapped_data.get(date_field), "%d-%m-%Y").strftime("%Y-%m-%d")
                    mapped_data[date_field] = new_date
                except ValueError:                    
                    logging.error("Invalid date format for field %s: %s", date_field, mapped_data.get(date_field))

        transaction_id = mapped_data.get('Transaction ID')
        if transaction_id in unique_transaction_ids:
            logging.error("vinod Duplicate Transaction ID found: %s", transaction_id)
            status = " RJCT"
        else:
            unique_transaction_ids.add(transaction_id)

        for lei_field in ['Reporting Counterparty Code', 'Non-Reporting Counterparty Code']:
            if not lei_field in mapped_data or not self.is_valid_lei(mapped_data.get(lei_field)):
                logging.error("vinod Invalid LEI format for field %s: %s", lei_field, mapped_data.get(lei_field))
                status = " RJCT"

        isin_value = mapped_data.get('Security identifier')
        if isin_value is not None and not bool(re.match(r'^[A-Z0-9]{1,10}$', isin_value)):
            status = " RJCT"


        enrichment_data = {col: mapped_data.get(col) for col in ENRICHMENT_COLUMNS}
        import apache_beam as beam
        yield beam.pvalue.TaggedOutput('response_data', {'Transaction ID': mapped_data['Transaction ID'], 'Status': status})
        yield beam.pvalue.TaggedOutput('enrich_data', enrichment_data)


class WriteToCSV(WriteToText):
    def process(self, file_handle, value):
        logging.info("vinod inside WriteToCSV", value)
        if not self._header:
            self._header = [str(key) for key in value.keys()]
            header_res = ','.join(self._header) + '\n'
            logging.info("header is ", ','.join(self._header) + '\n')
            file_handle.write(header_res)

        # Write the record to the CSV file
        str_response = ','.join(str(value[key]) for key in self._header) + '\n'
        logging.info("Vinod str response is ", str_response)
        file_handle.write(str_response)

# class WriteToCSV(beam.DoFn):
#     def process(self, element, file_path):
#         logging.info("Inside WriteToCSV")
#         logging.info("Vinod file path is ", file_path)
#         logging.info("file path type ", type(file_path))
#         if not hasattr(self, '_header'):
#             self._header = [str(key) for key in element.keys()]
#             with open(file_path, 'w', newline='') as csvfile:
#                 csv_writer = csv.writer(csvfile)
#                 csv_writer.writerow(self._header)

#         with open(file_path, 'a', newline='') as csvfile:
#             csv_writer = csv.writer(csvfile)
#             csv_writer.writerow([element[key] for key in self._header])


def run(argv=None):
    myoptions = PipelineOptions().view_as(MyOptions)
    logging.info("#"*150)
    logging.info(f"Vinod myoptions are :{myoptions}")
    logging.info("#"*150)
    p = beam.Pipeline(options=myoptions)
    # with beam.Pipeline(options=options) as p:
    data = p | 'ReadFile' >> beam.io.ReadFromText(myoptions.input_file_path)
    column_names = (
        data | 'GetFirstRow' >> beam.combiners.Top.Of(1) | 'FlattenList' >> beam.FlatMap(lambda x: x)
        | 'ProcessFirstRow' >> beam.ParDo(ProcessHeaderFn())
    )

    lines = p | 'ReadInputFile' >> beam.io.ReadFromText(myoptions.input_file_path, skip_header_lines=1)

    unique_transaction_ids = set()
    results = (
        lines
        | 'ValidateAndTransform' >> beam.ParDo(ValidateAndTransform(), 
                                               col_names=beam.pvalue.AsList(column_names),
                                               unique_transaction_ids=unique_transaction_ids
                                               ).with_outputs('response_data', 'enrich_data'))
    
    logging.info("#"*150)
    logging.info("Completed the ValidateAndTransform Stage")
    # Use the response_data_tag and enrich_data_tag to access the tagged results
    response_data = results.response_data
    enrich_data = results.enrich_data
    logging.info("#"*150)
    logging.info("Before writng to CSV")
    logging.info("#"*150)
    # final_resp = (
    #     response_data
    #     | 'WriteToCSVStatus' >> beam.ParDo(WriteToCSV(), file_path=myoptions.status_response_file_path))
    
    # final_resp2 = (
    #     enrich_data
    #     | 'WriteToCSVEnrichement' >> beam.ParDo(WriteToCSV(), file_path=myoptions.enrichment_response_file_path))
    
    response_data | 'WriteCSVOutput' >> WriteToCSV(myoptions.status_response_file_path)
    enrich_data | 'WriteCSVOutput2' >> WriteToCSV(myoptions.enrichment_response_file_path)
    # logging.info("After writng to CSV")
    p.run().wait_until_finish()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    # argv = [
    #   '--project={0}'.format(PROJECT),
    #   '--job_name=iris-case-study',
    #   '--save_main_session',
    #   '--staging_location=gs://{0}/staging/'.format(BUCKET),
    #   '--temp_location=gs://{0}/staging/'.format(BUCKET),
    #   '--region={0}'.format(REGION),
    #   '--worker_machine_type=e2-standard-2',
    #   '--runner=DataflowRunner']
    
    run()
