import argparse
import apache_beam as beam
from apache_beam import window
from apache_beam.options.pipeline_options import PipelineOptions

import json


class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        # parser.add_value_provider_argument(
        #     '--table_name',
        #     default='',
        #     type=str,
        #     required=False,
        #     help='table id.')
        
        # parser.add_value_provider_argument(
        # '--subscription',
        # dest='subscription',
        # default='projects/refined-kite-408510/subscriptions/sample-test-sub',
        # help='Input Pub/Sub subscription')
        

        parser.add_argument(
            '--table_name',
            default='',
            required=False,
            help='table id.'
            )

        parser.add_argument(
            '--subscription',
            default='',
            required=False,
            help='Input Pub/Sub subscription'
        )


def within_limit(x, limit):
        return x['duration'] <= limit


class CountAndMeanFn(beam.CombineFn):


    def create_accumulator(self):
        return 0.0, 0

    def add_input(self, sum_count, input):
        (sum, count) = sum_count
        return sum + input['duration'], count + 1

    def merge_accumulators(self, accumulators):
        sums, counts = zip(*accumulators)
        return sum(sums), sum(counts)

    def extract_output(self, sum_count):
        (sum, count) = sum_count
        from datetime import datetime

        return {
            'processing_time': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
            'count': count,
            'mean': sum / count if count else float('NaN')
        }


def run(argv=None, save_main_session=True):
    
    myoptions = PipelineOptions(streaming=True).view_as(MyOptions)

    with beam.Pipeline(options=myoptions) as p:
        table_schema = {
            'fields': [
                {'name': 'processing_time', 'type': 'TIMESTAMP', 'mode': 'NULLABLE'}, 
                {'name': 'count', 'type': 'FLOAT', 'mode': 'NULLABLE'},
                {'name': 'mean', 'type': 'FLOAT', 'mode': 'NULLABLE'}
            ]
        }

        (p
            | 'Read from pubsub' >> beam.io.ReadFromPubSub(subscription=myoptions.subscription)
            | 'To Json' >> beam.Map(lambda e: json.loads(e.decode('utf-8')))
            | 'Filter' >> beam.Filter(within_limit, 500)
            | 'Window' >> beam.WindowInto(window.FixedWindows(120))
            | 'Calculate Metrics' >> beam.CombineGlobally(CountAndMeanFn()).without_defaults()
            | 'Write to BigQuery' >> beam.io.WriteToBigQuery(
                        myoptions.table_name,
                        schema=table_schema,
                        method="STREAMING_INSERTS",
                        write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND,
                        create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED))

    
if __name__ == '__main__':
  run() 