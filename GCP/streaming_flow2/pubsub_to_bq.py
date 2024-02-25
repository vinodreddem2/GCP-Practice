import json
import logging
import apache_beam as beam
from apache_beam.io.gcp.bigquery import WriteToBigQuery

from apache_beam.options.pipeline_options import PipelineOptions


class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_value_provider_argument(
            '--table_name',
            default='',
            type=str,
            required=False,
            help='table id.')


def run():

    myoptions = PipelineOptions().view_as(MyOptions)
    p = beam.Pipeline(options=myoptions)

    # Read messages from Pub/Sub
    messages = (
        p
        | 'ReadFromPubSub' >> beam.io.ReadFromPubSub(topic='projects/refined-kite-408510/topics/dataflow_to_topic')
        | 'DecodeMessages' >> beam.Map(lambda x: json.loads(x.decode('utf-8')))
    )   

    messages | "WriteToBigQuery" >> WriteToBigQuery(
                        table=myoptions.table_name,
                        schema="create_time:datetime,name:string,email:string,address:string,phone_number:string",
                        create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                        write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND,
                        method="STREAMING_INSERTS"
                    )

    p.run().wait_until_finish()

if __name__ == '__main__':
    run()
