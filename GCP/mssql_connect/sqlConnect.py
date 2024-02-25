import logging
import apache_beam as beam

from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.jdbc import ReadFromJdbc

def connection_to_mssql():
    try:
        myoptions = PipelineOptions()
        p = beam.Pipeline(options=myoptions)
        result = (
        p
        | 'Read from jdbc' >> ReadFromJdbc(
            table_name='test',
            driver_class_name='com.microsoft.sqlserver.jdbc.SQLServerDriver',
            jdbc_url='jdbc:sqlserver://127.0.0.1:1433;databaseName=gcp_practice',
            username='mssqlserver',
            password='admin1234567890',
            query='select id from dbo.persons'
        ))
    except Exception as msg:
        print(f"exception msg : {msg}")

if __name__ == "__main__":
    connection_to_mssql()