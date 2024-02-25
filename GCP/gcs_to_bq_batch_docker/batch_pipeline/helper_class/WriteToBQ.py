import logging
import apache_beam as beam
from google.cloud import bigquery

class writeToBQ(beam.DoFn):

    def __init__(self,table_id,project_id):
        logging.info(f"in initial")
        self.table = table_id
        self.project_id = project_id

    def start_bundle(self):
        logging.info(f"in start bundle")
        self.client = bigquery.Client(project=self.project_id.get())

    def process(self,element):

        logging.info(f"len of element: {len(element)}")
        # logging.info(f"element: {element}")

        errors = self.client.insert_rows_json(self.table.get(), element)  # Make an API request.
        if errors == []:
            logging.info("New rows have been added.")
        else:
            logging.info("Encountered errors while inserting rows: {}".format(errors))
