import apache_beam as beam
from apache_beam import pvalue
import logging
import re
from apache_beam.io import WriteToText
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.filesystems import FileSystems

PROJECT = 'gcp-practice-project-410806'
BUCKET = 'iris-case-study'
REGION = 'us-central1'
INPUT_FILE = 'gs://{}/input_file/input.csv'.format(BUCKET)
OUTPUT_FILE_CSV = 'gs://{}/output/output.csv'.format(BUCKET)
OUTPUT_FILE_CSV2 = 'gs://{}/output/output2.csv'.format(BUCKET)

def parse_pubsub_message(message):
    """Parse the JSON-encoded Pub/Sub message."""
    file_info = json.loads(message.data.decode('utf-8'))
    return file_info

def process_file_info(element):
    """Process the file information."""
    bucket_name = element['bucket_name']
    file_name = element['file_name']

class ProcessPubSub(beam.DoFn):
    def process(self, element):
        print(element)
        logging.info(element)
        bucket_name = element['bucket_name']
        file_name = element['file_name']
        yield bucket_name
        yield file_name

def run(argv=None):
    options = PipelineOptions(argv)
    with beam.Pipeline(options=options) as p:
        pubsub_messages = (
        p | beam.io.ReadFromPubSub(subscription='projects/gcp-practice-project-410806/subscriptions/iris-case-study-bucket-sub').with_output_types(bytes))

        lines = pubsub_messages | 'decode' >> beam.Map(lambda x: x.decode('utf-8'))
        # Process file information
        # results = (
        #     lines
        #     | 'processPubSubMessege' >> beam.ParDo(ProcessPubSub()).with_outputs('bucket_name', 'file_name'))
        # # processed_data = pubsub_messages | beam.Map(process_file_info)
        # # data = {"bucket":results.bucket_name, "file_name":results.file_name}
        # results | 'WriteOutput2' >> beam.io.WriteToText('gs://iris-case-study/output/output2.txt')
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