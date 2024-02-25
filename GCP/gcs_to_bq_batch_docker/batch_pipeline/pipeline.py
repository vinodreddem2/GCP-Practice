import logging
import apache_beam as beam

from apache_beam.options.pipeline_options import PipelineOptions
from helper_class.MyOptions import MyOptions
from helper_class.Validation import validateRows
from helper_class.WriteToBQ import writeToBQ

def gcs_to_bq_pipeline():

    try:
        
        myoptions = PipelineOptions().view_as(MyOptions)
        p = beam.Pipeline(options=myoptions)

        table_schema = 'VendorID:INTEGER,tpep_pickup_datetime:TIMESTAMP,tpep_dropoff_datetime:TIMESTAMP,passenger_count:INTEGER,trip_distance:FLOAT,pickup_longitude:FLOAT,pickup_latitude:FLOAT,RatecodeID:INTEGER,store_and_fwd_flag:BOOLEAN,dropoff_longitude:FLOAT,dropoff_latitude:FLOAT,payment_type:INTEGER,fare_amount:FLOAT,extra:FLOAT,mta_tax:FLOAT,tip_amount:FLOAT,tolls_amount:FLOAT,improvement_surcharge:FLOAT,total_amount:FLOAT'

        input_data = (
                p
                | "Read input data" >> beam.io.ReadFromText(myoptions.input,skip_header_lines=1)
                | "Parse CSV" >> beam.Map(lambda line: line.split(","))
        )

        batch_rows = input_data | "Batch elements" >> beam.BatchElements(min_batch_size=1000, max_batch_size=10000)


        bq_rows = (
            batch_rows
            | 'validate row' >> beam.ParDo(validateRows(myoptions.schema))
        )


        # bq_rows | "WriteToBigQuery" >> WriteToBigQuery(
        #                 table=myoptions.table_id,
        #                 schema=table_schema,
        #                 create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
        #                 write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND,
        #                 method="STREAMING_INSERTS"
        #             )  

        bq_rows | "write to bq table" >> beam.ParDo(writeToBQ(myoptions.table_id,myoptions.project_id))

        p.run().wait_until_finish()

    except Exception as e_msg:
        print(f"exception at line {e_msg.__traceback__.tb_lineno}:{e_msg}")


if __name__ == "__main__":
    gcs_to_bq_pipeline()