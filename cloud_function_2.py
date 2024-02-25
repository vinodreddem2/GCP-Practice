import base64
import json
from google.cloud.storage import Client, transfer_manager
import pandas as pd
from concurrent.futures import ThreadPoolExecutor
import re
import logging
from datetime import datetime
import io


ISIN = ' Security identifier'
LEI = ['Reporting Counterparty Code', 'Non-Reporting Counterparty Code']
DATE = ['Event date', 'Value date', 'Loan Maturity of the security']
MANDATORY_FIELDS = ['Transaction ID', 'Reporting Counterparty Code', 'Non-Reporting Counterparty Code', 'Security identifier']
ENRICHMENT_COLUMNS = ['Type of asset', 'Security identifier', 'Classification of a security',
                      'Loan Base product', 'Loan Sub product', 'Loan Further sub product',
                      'Loan LEI of the issuer', 'Loan Maturity of the security', 'Loan Jurisdiction of the issuer']



def read_file_from_cloud_storage(bucket_name, file_name, chunk_size=50000):
    storage_client = Client()
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(file_name)
    content = blob.download_as_text()
    # df = pd.read_csv(io.StringIO(content))
    # df.columns = df.columns.str.strip()
    # response_data_df, enrich_data_df = apply_validations(df)
    # total_lines = sum(1 for _ in blob.download_as_text().split('\n'))

    # Use ThreadPoolExecutor to parallelize the reading of chunks    
    with ThreadPoolExecutor() as executor:
        futures = []
        for content in transfer_manager.download_chunks_concurrently(blob,"output_data/temp.txt",
                                                                   chunk_size=32 * 1024 * 1024, 
                                                                   max_workers=8):

        # start = 0
        # while True:
        #     content = blob.download_as_text(start=start, end=start + chunk_size).split('\n')
        #     if not content or len(content) == 1 and not content[0]:
        #         break
            futures.append(executor.submit(read_chunk, content))
            # start = start + chunk_size
        chunk_data = [future.result() for future in futures]

    # Concatenate the chunks into a single DataFrame for response and enrichment data
    
    response_data_df = pd.concat([chunk[0] for chunk in chunk_data], ignore_index=True)
    enrich_data_df = pd.concat([chunk[1] for chunk in chunk_data], ignore_index=True)
    return response_data_df, enrich_data_df

# def read_chunk(blob, start, end):
#     print(f"Inisde the read_chunk {start} - {end}")
#     chunk_data = pd.read_csv(blob, skiprows=range(1, start), nrows=end-start)   
    
#     chunk_data.columns = chunk_data.columns.str.strip()
#     print(chunk_data.columns)
#     response_data_df, enrich_data_df = apply_validations(chunk_data)
    
#     return response_data_df, enrich_data_df

def read_chunk(content):
    # Convert the content to a DataFrame
    chunk_data = pd.read_csv(io.StringIO('\n'.join(content)))

    # Perform any necessary preprocessing on chunk_data, if needed
    chunk_data.columns = chunk_data.columns.str.strip()

    # Apply validations and return response and enrichment data
    response_data_df, enrich_data_df = apply_validations(chunk_data)

    return response_data_df, enrich_data_df

def apply_validations(df):
    status = []

    # Define a function to apply validations and convert date format
    def validate_and_convert(row):
        try:
            current_status = "ACCPT"
            # Convert date columns from "dd-mm-yyyy" to "yyyy-mm-dd"
            for date_field in DATE:
                if date_field in df.columns and not pd.isnull(row[date_field]):
                    try:
                        new_date = datetime.strptime(row[date_field], "%d-%m-%Y").strftime("%Y-%m-%d")
                        row[date_field] = new_date
                    except ValueError:                    
                        logging.error("Invalid date format for field %s: %s", date_field, row[date_field])

            for field in MANDATORY_FIELDS:
                if field not in df.columns or pd.isnull(row[field]):               
                    current_status = " RJCT"
                    break

            # Check LEI format
            for lei_field in LEI:
                if lei_field in df.columns and not is_valid_lei(row[lei_field]):                
                    current_status = " RJCT"
                    break

            # Check ISIN format
            if ISIN in df.columns and not bool(re.match(r'^[A-Z0-9]{1,10}$', str(row[ISIN]))):
                current_status = " RJCT"
            logging.info(f"Trans Id - {row['Transaction ID']} status {current_status}")
            status.append(current_status)
            return row
        except Exception as ex:
            logging.error(f"Exception Occurred {ex}")
            return None
    # Apply the function to each row of the dataframe
    df = df.apply(lambda row: validate_and_convert(row), axis=1)

    # Add the status as a new column to the existing dataframe
    df['Status'] = status

    # Enrichment data
    print(ENRICHMENT_COLUMNS)
    print(df.columns)
    enrichment_data_df = df[ENRICHMENT_COLUMNS]
    response_data = df[['Transaction ID', 'Status']]
    return response_data, enrichment_data_df


def is_valid_lei(lei):
    return bool(re.match(r'^[A-Z0-9]{1,20}$', str(lei)))


def write_to_cloud_storage(dataframe, bucket_name, folder_name, file_name):
    print("Inside the write to cloud storage")
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(f"{folder_name}/{file_name}")
    content = dataframe.to_csv(index=False)
    blob.upload_from_string(content, content_type='text/csv')
    print("End  the write to cloud storage")


def hello_pubsub(event, context):
    pubsub_message = json.loads(base64.b64decode(event['data']).decode('utf-8'))
    print(pubsub_message)
    print(type(pubsub_message))
    bucket_name = pubsub_message['bucket']
    file_name = pubsub_message['name']

    # Read file from Cloud Storage in chunks
    response_data_df, enrich_data_df = read_file_from_cloud_storage(bucket_name, file_name)
    print("Response Data:")
    print(response_data_df.head())
    print("Enrichment Data:")
    print(enrich_data_df.head())
    folder_name = "output_data"
    write_to_cloud_storage(response_data_df, bucket_name, folder_name, 'response_data.csv')
    write_to_cloud_storage(enrich_data_df, bucket_name, folder_name, 'enrichment_data.csv')



