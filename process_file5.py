#!/usr/bin/env python
import argparse
import json
import os
import logging
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions, StandardOptions

logging.basicConfig(level=logging.INFO)
logging.getLogger().setLevel(logging.INFO)



class CustomParsing(beam.DoFn):
    """ Custom ParallelDo class to apply a custom transformation """
    def process(self, element: bytes):
        """
        Simple processing function to parse the data and add a timestamp
        For additional params see:
        https://beam.apache.org/releases/pydoc/2.7.0/apache_beam.transforms.core.html#apache_beam.transforms.core.DoFn
        """
        parsed = json.loads(element.decode("utf-8"))
        yield parsed

PROJECT = 'gcp-practice-project-410806'
BUCKET = 'iris-case-study'
REGION = 'us-central1'

from apache_beam.transforms.window import FixedWindows
from apache_beam.transforms.trigger import AfterWatermark, AfterProcessingTime

def run():
    # Parsing arguments
    argv = [
      '--project={0}'.format(PROJECT),
      '--job_name=iris-case-study',
      '--save_main_session',
      '--staging_location=gs://{0}/staging/'.format(BUCKET),
      '--temp_location=gs://{0}/staging/'.format(BUCKET),
      '--region={0}'.format(REGION),
      '--worker_machine_type=e2-standard-2',
      '--runner=DataflowRunner']
      
    pipeline_options = PipelineOptions(argv)
    # Defining our pipeline and its steps
    with beam.Pipeline(options=pipeline_options) as p:
        messages = (
            p
            | "ReadFromPubSub" >> beam.io.gcp.pubsub.ReadFromPubSub(
                subscription='projects/gcp-practice-project-410806/subscriptions/iris-case-study-bucket-sub'
            )
        )
        print(messages)
        # lines = messages | 'decode' >> beam.Map(lambda x: x.decode('utf-8'))

        # def printattr(element):
        #     print(element.attributes)


        # lines2 = messages | 'printattr' >> beam.Map(printattr)
        # lines | 'WriteOutput' >> beam.io.WriteToText('gs://iris-case-study/output/output.txt')

if __name__ == "__main__":
    run()