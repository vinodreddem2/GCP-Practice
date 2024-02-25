import apache_beam as beam

def process_element(element):
    # Your processing logic goes here
    return "Adding" + str(element)

def run(input_file, output_path):
    with beam.Pipeline() as pipeline:
        (
            pipeline
            | 'ReadFromText' >> beam.io.ReadFromText(input_file)
            | 'ProcessElements' >> beam.Map(process_element)
            | 'WriteToText' >> beam.io.WriteToText(output_path)
        )

if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument('--inputFile', required=True, help='Path to the input file')
    parser.add_argument('--outputPath', required=True, help='Path to the output directory')
    args = parser.parse_args()

    run(args.inputFile, args.outputPath)
