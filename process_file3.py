import apache_beam as beam
from apache_beam import pvalue
import logging
import re
from apache_beam.io import WriteToText
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.filesystems import FileSystems

logging.getLogger().setLevel(logging.INFO)

PROJECT = 'gcp-practice-project-410806'
BUCKET = 'iris-case-study'
REGION = 'us-central1'
INPUT_FILE = 'gs://{}/input_file/input.csv'.format(BUCKET)
OUTPUT_FILE_CSV = 'gs://{}/output/output.csv'.format(BUCKET)
OUTPUT_FILE_CSV2 = 'gs://{}/output/output2.csv'.format(BUCKET)

ISIN = ' Security identifier'
LEI = ['Reporting Counterparty Code', 'Non-Reporting Counterparty Code']
DATE = [' Event date', ' Value date', ' Loan Maturity of the security']
MANDATORY_FIELDS = ['Transaction ID', 'Reporting Counterparty Code', 'Non-Reporting Counterparty Code', ' Security identifier']
ENRICHMENT_COLUMNS = ['Type of asset', 'Security identifier', ' Classification of a security',
                      ' Loan Base product', ' Loan Sub product', ' Loan Further sub product',
                      'Loan LEI of the issuer', ' Loan Maturity of the security', ' Loan Jurisdiction of the issuer ']


class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):

        parser.add_value_provider_argument(
            '--project_id',
            default = 'spiritual-clock-410718',
            type = str,
            required = False,
            help = "GCP Project to run the Dataflow Job"
        )

        parser.add_value_provider_argument(
            '--region',
            default='us-central1',
            type=str,
            required=False,
            help='Input csv file to read.')

        parser.add_value_provider_argument(
            '--input_file_path',
            default='gs://iris-gcp-cstudy/Input_data/data_sample.csv',
            type=str,
            required=True,
            help='Input csv file to read.')
        
        parser.add_value_provider_argument(
            '--enrichment_response_file_path',
            default='gs://gcp_practice_95/data_sample.csv',
            type=str,
            required=True,
            help='Input csv file to read.'
        )

        parser.add_value_provider_argument(
            '--status_response_file_path',
            default='gs://gcp_practice_95/data_sample.csv',
            type=str,
            required=True,
            help='Input csv file to read.'
        )
        

class ProcessHeaderFn(beam.DoFn):
    def process(self, element):
        column_names = element.split(',')
        logging.info("vinod Column names are: %s", column_names)
        yield column_names

class ValidateAndTransform(beam.DoFn):
    def is_valid_lei(self, lei):
        return bool(re.match(r'^[A-Z0-9]{20}$', lei))

    def process(self, element, col_names, unique_transaction_ids):
        logging.info("vinod Processing data: %s", element)
        column_names = col_names[0]
        logging.info("vinod Column inside ValidateAndTransform names are: %s", column_names)
        logging.info("type of the column names are :%s", type(col_names))
        mapped_data = {column_names[i]: value for i, value in enumerate(element.split(','))}
        logging.info("vinod Mapped data: %s", mapped_data)

        status = None
        for field in MANDATORY_FIELDS:
            if field not in mapped_data or not mapped_data.get(field) or mapped_data.get(field).strip() == '':
                logging.error("vinod Missing or empty value for mandatory field: %s", field)
                status = " RJCT"

        transaction_id = mapped_data.get('Transaction ID')
        if transaction_id in unique_transaction_ids:
            logging.error("vinod Duplicate Transaction ID found: %s", transaction_id)
            status = " RJCT"
        else:
            unique_transaction_ids.add(transaction_id)

        for lei_field in LEI:
            if not lei_field in mapped_data or not self.is_valid_lei(mapped_data.get(lei_field)):
                logging.error("vinod Invalid LEI format for field %s: %s", lei_field, mapped_data.get(lei_field))
                status = " RJCT"
        if not bool(re.match(r'^[A-Z0-9]{20}$', mapped_data.get(ISIN))):
            status = " RJCT"

        enrichment_data = {col: mapped_data.get(col) for col in ENRICHMENT_COLUMNS}
        yield beam.pvalue.TaggedOutput('response_data', {'Transaction ID': mapped_data['Transaction ID'], 'Status': status})
        yield beam.pvalue.TaggedOutput('enrich_data', enrichment_data)

class WriteToCSV(WriteToText):
    def write_record(self, file_handle, value):
        logging.info("Your log message", file_handle)
        logging.info(value)
        print(value)
        if not self._header:
            self._header = [str(key) for key in value.keys()]
            file_handle.write(','.join(self._header) + '\n')

        # Write the record to the CSV file
        file_handle.write(','.join(str(value[key]) for key in self._header) + '\n')

def run(argv=None):
    options = PipelineOptions(argv)
    with beam.Pipeline(options=options) as p:
        data = p | 'ReadFile' >> beam.io.ReadFromText(INPUT_FILE)
        column_names = (
            data | 'GetFirstRow' >> beam.combiners.Top.Of(1) | 'FlattenList' >> beam.FlatMap(lambda x: x)
            | 'ProcessFirstRow' >> beam.ParDo(ProcessHeaderFn())
        )

        lines = p | 'ReadInputFile' >> beam.io.ReadFromText(INPUT_FILE, skip_header_lines=1)

        unique_transaction_ids = set()
        # results = (
        #     lines | 'ValidateAndTransform' >> beam.ParDo(ValidateAndTransform(), col_names=beam.pvalue.AsList(column_names))
        # )
        # # Define tagged outputs
        # response_data_tag = 'response_data'
        # enrich_data_tag = 'enrich_data'
        results = (
                lines
                | 'ValidateAndTransform' >> beam.ParDo(ValidateAndTransform(), col_names=beam.pvalue.AsList(column_names), 
                                                       unique_transaction_ids=unique_transaction_ids
                                                       ).with_outputs('response_data', 'enrich_data'))

        # Use the response_data_tag and enrich_data_tag to access the tagged results
        response_data = results.response_data
        enrich_data = results.enrich_data

        response_data | 'WriteCSVOutput' >> WriteToCSV(OUTPUT_FILE_CSV)
        enrich_data | 'WriteCSVOutput2' >> WriteToCSV(OUTPUT_FILE_CSV2)
        # p.run()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    argv = [
      '--project={0}'.format(PROJECT),
      '--job_name=iris-case-study',
      '--save_main_session',
      '--staging_location=gs://{0}/staging/'.format(BUCKET),
      '--temp_location=gs://{0}/staging/'.format(BUCKET),
      '--region={0}'.format(REGION),
      '--worker_machine_type=e2-standard-2',
      '--runner=DataflowRunner']
    
    run(argv)
