
from googleapiclient.discovery import build
import json
import base64


def start_dataflow_job(input_file_path):
    # Set your GCP project and Dataflow job parameters
    project_id = 'spiritual-clock-410718'
    region = 'us-central1'
    template_gcs_path = 'gs://iris-cstudy-output/template'  # Path to your Dataflow template file
    staging_location = 'gs://iris-cstudy-output/staging'
    job_name = 'isir-case-study'
    parameters = {
        'project_id': "spiritual-clock-410718",
        'working_region': "us-central1",
        'input_file_path': input_file_path,
        'enrichment_response_file_path': "gs://iris-cstudy-output/output/enrichment_response.csv",
        'status_response_file_path': "gs://iris-cstudy-output/output/status_response.csv"
    }

    # Build the Dataflow API client
    dataflow = build('dataflow', 'v1b3')

    # Create a job spec based on the template and parameters
    job_spec = {
        'jobName': job_name,
        'parameters': parameters,
        'environment': {
            'tempLocation': staging_location,
            'zone': region + '-b',
        }        
    }

    # Submit the Dataflow job
    request = dataflow.projects().locations().templates().launch(
        projectId=project_id,
        location=region,
        body=job_spec,
        gcsPath = template_gcs_path,
    )
    response = request.execute()

    print(f"Dataflow job {job_name} started: {response}")


def hello_pubsub(event, context):
    pubsub_message = json.loads(base64.b64decode(event['data']).decode('utf-8'))
    print(pubsub_message)
    print(type(pubsub_message))
    bucket_name = pubsub_message['bucket']
    file_name = pubsub_message['name']

    # Read file from Cloud Storage in chunks
    input_file_path = f"{bucket_name}/{file_name}"
    if "input" in input_file_path.lower():
        start_dataflow_job(input_file_path)
