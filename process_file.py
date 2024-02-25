import apache_beam as beam
from apache_beam.io import ReadFromText

class Preprocess(beam.DoFn):
    def process(self, element):
        # Assume the first element contains the header with column names
        column_names = element.split(',')
        # Emit the column names as a side output
        yield beam.pvalue.TaggedOutput('column_names', column_names)

class ValidateAndTransform(beam.DoFn):
    def process(self, element, col_names):
        # Your validation and transformation logic goes here
        data = element
        yield data

if __name__ == '__main__':
    with beam.Pipeline() as p:
        input_file = 'gs://iris-case-study/input_file/input.csv'

        # Read the file and skip the header line
        column_names = (
            p
            | 'ReadHeader' >> beam.io.ReadFromText(input_file, skip_header_lines=0)
            | 'Preprocess' >> beam.ParDo(Preprocess()).with_outputs('column_names', main='main')
            | 'ExtractColumnNames' >> beam.Map(lambda x: x['column_names'])
        )

        lines = (
            p | 'ReadInputFile' >> ReadFromText(input_file, skip_header_lines=1)
        )

        results = (
            (lines, column_names)
            | 'ValidateAndTransform' >> beam.ParDo(ValidateAndTransform())
        )

        # Output the processed data as needed
        results | 'WriteOutput' >> beam.io.WriteToText('gs://iris-case-study/output/output.txt')
