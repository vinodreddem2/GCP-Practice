import apache_beam as beam
from apache_beam.io.gcp.bigquery import WriteToBigQuery
from apache_beam.options.pipeline_options import PipelineOptions

from .helper_class.validation_data import ValidateCSVRow
from .helper_class.Pipeline_Options import MyOptions

from datetime import datetime


def gcs_to_bq_pipeline():

    csv_data_to_validate = [str,str,str,str,str,bool,int,int,int,datetime,datetime]

    table_schema = 'customer_id:STRING,store_id:STRING,first_name:STRING,last_name:STRING,' \
               'email:STRING,is_active:BOOLEAN,birth_day:INTEGER,birth_month:INTEGER,birth_year:INTEGER,' \
               'create_date:DATE,last_update_date:DATE'

    try:
        myoptions = PipelineOptions().view_as(MyOptions)
        myoptions.set(auto)
        p = beam.Pipeline(options=myoptions)

        data = p | beam.io.ReadFromText(myoptions.input_file_path,skip_header_lines=1)
        bq_data = data | beam.ParDo(ValidateCSVRow(schema = csv_data_to_validate))
        bq_data | "WriteToBigQuery" >> WriteToBigQuery(
                        table=myoptions.table,
                        schema=table_schema,
                        create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                        write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND,
                        method="STREAMING_INSERTS"
                    )

        p.run().wait_until_finish()

    except Exception as e_msg:
        print(f"exception:{e_msg}")


