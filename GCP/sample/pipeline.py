import json
import logging
import apache_beam as beam
import mysql.connector

from apache_beam.options.pipeline_options import PipelineOptions

class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_value_provider_argument(
            '--input',
            default='gs://gcp_practice_95/data_sample.csv',
            type=str,
            required=False,
            help='Input csv file to read.')

        parser.add_value_provider_argument(
            '--project_id',
            default='project1',
            type=str,
            required=False,
            help='provide project')
        
        parser.add_value_provider_argument(
            '--query',
            default='query1',
            type=str,
            required=False,
            help='provide query')


class MySQLConnect(beam.DoFn):
    def __init__(self, query):
        self.query = query

    def process(self,element):
        logging.info(f"in process")
        logging.info(f"mysql_config_details : {element}")

        config = {
            'user': element["user"],
            'password': element["password"],
            'host': element["host"],
            'database': element["database"],
            'port': '3306',
            'raise_on_warnings': True
        }
        mydb = mysql.connector.connect(**config)
        cursor = mydb.cursor(buffered=True)
        sql_query = self.query.get()
        logging.info(f"sql_query : {sql_query}")
        cursor.execute(sql_query)
        data = cursor.fetchall()
        logging.info(f"data : {data}")
        cursor.close()
        mydb.close()
    


def sql_pipeline():

    try:
        myoptions = PipelineOptions().view_as(MyOptions)
        p = beam.Pipeline(options=myoptions)

        input_data = (
                p
                | "Read input data" >> beam.io.ReadFromText(myoptions.input)
                | "Parse Json" >> beam.Map(lambda x: json.loads(x))
        )

        input_data | "Fetch SQL Data" >> beam.ParDo( MySQLConnect(myoptions.query) )


        p.run().wait_until_finish()

    except Exception as e_msg:
        print(f"exception at line {e_msg.__traceback__.tb_lineno}:{e_msg}")

if __name__ == '__main__':
    sql_pipeline()