from datetime import datetime, timedelta
from airflow import DAG
from airflow.contrib.sensors.gcs_sensor import GoogleCloudStorageObjectSensor
from airflow.operators.bash_operator import BashOperator

default_args = {
    'owner': 'your_owner',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 18),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
}

dag = DAG(
    'gcs_file_upload_trigger',
    default_args=default_args,
    description='Trigger DAG when a new file is uploaded to GCS',
    schedule_interval=timedelta(days=1),  # Adjust as needed
)

# Define the GCS bucket and object path
gcs_bucket = 'gcp-practice-95'
gcs_object_path = 'source/'

# Define the sensor task to monitor GCS for new files
gcs_sensor = GoogleCloudStorageObjectSensor(
    task_id='gcs_file_sensor',
    bucket=gcs_bucket,
    object=gcs_object_path,
    mode='poke',  
    poke_interval=600,
    timeout=600,
    dag=dag,
)

# Define the task to be executed when a new file is detected
process_file_task = BashOperator(
    task_id='process_file',
    bash_command='echo "Processing file: gs://{}/{}"',
    dag=dag,
)

# Set task dependencies
gcs_sensor >> process_file_task
