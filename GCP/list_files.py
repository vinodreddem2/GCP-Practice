from datetime import datetime, timedelta
from google.cloud import storage

file_ext = f"{datetime.utcnow().strftime('%Y%m%d')}"
prefix_value = f"source/data_{file_ext}"

def list_objects_in_folder(prefix_value):
    # Initialize a GCS client
    client = storage.Client()

    # Get the bucket
    bucket_name = 'gcp-practice-95'
    bucket = client.get_bucket(bucket_name)

    # List objects in the specified folder
    blobs = bucket.list_blobs(prefix=prefix_value)

    fileNames = []
    for blob in blobs:
        print(blob.name)
        if blob.name.split("/")[-1].__contains__(file_ext):
            fileNames.append(blob.name.split("/")[-1])

    print(fileNames)

list_objects_in_folder(prefix_value)