import base64
import json
from google.cloud import storage
import pandas as pd
import io

def read_file_from_cloud_storage(bucket_name, file_name):
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(file_name)
    # Download the file
    content = blob.download_as_text()
    # Convert the content to a DataFrame
    df = pd.read_csv(io.StringIO(content))

    return df


def hello_pubsub(event, context):
    pubsub_message = json.loads(base64.b64decode(event['data']).decode('utf-8'))
    print(pubsub_message)
    print(type(pubsub_message))
    bucket_name = pubsub_message['bucket']
    file_name = pubsub_message['name']

    # Read file from Cloud Storage
    df = read_file_from_cloud_storage(bucket_name, file_name)
    print(df.head())
