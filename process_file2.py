import apache_beam as beam

class ProcessHeaderFn(beam.DoFn):
    def process(self, element):
        # Assume the first element contains the header with column names
        column_names = element.split(',')
        print("vinod column names are inside ProcessHeaderFn", column_names)
        yield column_names

class ValidateAndTransform(beam.DoFn):
    def process(self, element, col_names):
        # Your validation and transformation logic goes here
        data = element
        # Process data using column names
        # ...
        yield data

PROJECT='gcp-practice-project-410806'
BUCKET='iris-case-study'
REGION='us-central1'


if __name__ == '__main__':

    argv = [
      '--project={0}'.format(PROJECT),
      '--job_name=iris-case-study',
      '--save_main_session',
      '--staging_location=gs://{0}/staging/'.format(BUCKET),
      '--temp_location=gs://{0}/staging/'.format(BUCKET),
      '--region={0}'.format(REGION),
      '--worker_machine_type=e2-standard-2',
      '--runner=DataflowRunner']
    p = beam.Pipeline(argv=argv)
     
    # with beam.Pipeline() as p:
    input_file = 'gs://iris-case-study/input_file/input.csv'

    # Read the file and extract the header line (column names)
    column_names = (
        p
        | 'ReadHeader' >> beam.io.ReadFromText(input_file)
        | 'ProcessHeader' >> beam.ParDo(ProcessHeaderFn())
    )
    print("vinod column names are ", column_names)
    # Print the column names using beam.Map
    _ = column_names | 'PrintColumnNames' >> beam.Map(print)

    # Read the rest of the file, skipping the header
    lines = (
        p | 'ReadInputFile' >> beam.io.ReadFromText(input_file, skip_header_lines=1)
    )

    results = (
        lines
        | 'ValidateAndTransform' >> beam.ParDo(ValidateAndTransform(), col_names=beam.pvalue.AsList(column_names))
    )

    # Output the processed data as needed
    results | 'WriteOutput' >> beam.io.WriteToText('gs://iris-case-study/output/output.txt')
    column_names | 'WriteOutput2' >> beam.io.WriteToText('gs://iris-case-study/output/output2.txt')
    p.run()