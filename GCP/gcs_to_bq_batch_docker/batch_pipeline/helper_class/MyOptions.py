import apache_beam as beam
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
            '--dataset_id',
            default='dataset1',
            type=str,
            required=False,
            help='provide dataset_id')
        
        parser.add_value_provider_argument(
            '--table_id',
            default='table1',
            type=str,
            required=False,
            help='provide table_id')

        parser.add_value_provider_argument(
            '--batch_size',
            default=10,
            type=int,
            required=False,
            help='provide size of baatch')
        
        parser.add_value_provider_argument(
            '--schema',
            default="schema1",
            type=str,
            required=False,
            help='provide schema')
