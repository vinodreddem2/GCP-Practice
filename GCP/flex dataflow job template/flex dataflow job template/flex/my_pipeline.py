import argparse
import time
import json
import typing
import logging
import apache_beam as beam
from apache_beam.options.pipeline_options import GoogleCloudOptions
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import StandardOptions
from apache_beam.runners import DataflowRunner, DirectRunner
# from apache_beam.transforms.combiners import Sample

class rows (typing.NamedTuple):
    id: int
    Date: str
    amount: int
    purchases: int

# def extract(da):
#     date_object = datetime.strptime(da[1], '%d/%m/%Y')
#     a=date_object.strftime("%B %Y")
#     b=rows(id=da[0], Date=a, amount=da[2], purchases=da[3])
#     return b

# beam.coders.registry.register_coder(rows, beam.coders.RowCoder)

def parse_json(element):
    row = json.loads(element)
    return rows(**row)

def run():
    # Command line arguments
    parser = argparse.ArgumentParser(description='Load from Json into BigQuery')
    parser.add_argument('--project',required=True, help='Specify Google Cloud project')
    parser.add_argument('--region', required=True, help='Specify Google Cloud region')
    parser.add_argument('--runner', required=True, help='Specify Apache Beam Runner')
    parser.add_argument('--input_path', required=True, help='Path to events.json')
    parser.add_argument('--staging_location', required=True, help='Specify Cloud Storage bucket for staging')
    parser.add_argument('--temp_location', required=True, help='Specify Cloud Storage bucket for temp')

    opts, pipeline_opts = parser.parse_known_args()

    # Setting up the Beam pipeline options
    options = PipelineOptions(pipeline_opts, save_main_session=True)
    options.view_as(GoogleCloudOptions).project = opts.project
    options.view_as(GoogleCloudOptions).region = opts.region
    options.view_as(GoogleCloudOptions).staging_location = opts.staging_location
    options.view_as(GoogleCloudOptions).temp_location = opts.temp_location
    options.view_as(GoogleCloudOptions).job_name = 'aggfacts'
    options.view_as(StandardOptions).runner = opts.runner
    input_path = opts.input_path

    p = beam.Pipeline(options=options)

    agg = (p| 'ReadFromGCS' >> beam.io.ReadFromText(input_path)
            | 'ParseJson' >> beam.Map(parse_json).with_output_types(rows) # for "CSV" >> beam.Map(lambda x:x.split(","))
            # | 'extract' >> beam.Map(extract)
            # | beam.GroupBy('id','Date').aggregate_field('amount', sum, 'total_amount').aggregate_field('purchases', sum, 'total_purchases')
            | 'Map' >> beam.Map(lambda x: {"id":x[0],"Month":x[1], "amount":x[2],"purchases":x[3]})
            # | beam.Map(print)
            | 'WritePerToBQ' >> beam.io.WriteToBigQuery(
             'ds_L.flex_test',
            #  schema='id:STRING',
            schema='SCHEMA_AUTODETECT',
            create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
            write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE
         )
        )

    # logging.getLogger().setLevel(logging.INFO)
    # logging.info("Building pipeline ...")

   
    p.run()

if __name__ == '__main__':
  run()


#      for creating classic temp use "--template_location" last in cli ------create temp cli below 👇
# python3 agg_facts.py --project=poc-task-379506 --region=asia-east1 --runner=DataflowRunner --input_path=gs://bt_poc/agg_facts.json --staging_location=gs://bt_poc/temp2  --temp_location=gs://bt_poc/temp1 --template_location gs://bt_poc/Templates/agg_facts

#       for running job using template template 👇
#  we can either by dataflow interface (create job from template) or by running below cli
#  gcloud dataflow jobs run "agg_facts" --gcs-location=gs://bt_poc/Templates --region=asia-east1 --worker-region=europe-west2 --max-workers=2 --num-workers=2