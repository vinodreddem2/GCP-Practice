from apache_beam.options.pipeline_options import PipelineOptions

class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_value_provider_argument(
            '--input_file_path',
            default='gs://gcp_practice_95/data_sample.csv',
            type=str,
            required=False,
            help='Input csv file to read.')

        parser.add_value_provider_argument(
            '--table',
            default='sturdy-method-401407.gcp_practice.customer_info_tbl',
            type=str,
            required=False,
            help='Input table id ')



