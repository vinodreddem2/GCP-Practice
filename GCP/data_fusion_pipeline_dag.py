from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.google.cloud.operators.datafusion import CloudDataFusionStartPipelineOperator
from airflow.providers.google.cloud.hooks.datafusion import PipelineStates
from airflow.operators.dummy import DummyOperator
from airflow.operators.python_operator import PythonOperator, BranchPythonOperator

from google.cloud import storage


# Define default_args dictionary to set the default parameters for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 18),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=30),
}

file_ext = f"{datetime.utcnow().strftime('%Y%m%d')}"
prefix_value = f"source/data_{file_ext}"


# Create a DAG object
dag = DAG(
    'example_datafusion_pipeline_dag',
    default_args=default_args,
    description='An example Airflow DAG using Cloud Data Fusion',
    schedule_interval=None
    )


def get_object_in_folder(**kwargs):
    client = storage.Client()

    bucket_name = 'gcp-practice-95'
    bucket = client.get_bucket(bucket_name)

    blobs = bucket.list_blobs(prefix=kwargs.get('folder_prefix'))

    fileNames = []
    for blob in blobs:
        print(blob.name)
        if blob.name.split("/")[-1].__contains__(file_ext):
            fileNames.append(blob.name.split("/")[-1])

    print(fileNames)
    
    if len(fileNames):
        ti = kwargs['ti']
        ti.xcom_push(key='file_name', value=fileNames[0])
        return 'start_datafusion_pipeline'
    else:
        return 'file_not_exists'

    
start_task = DummyOperator(task_id='start',dag=dag)
    
end_task = DummyOperator(task_id='end', trigger_rule='one_success', dag=dag)

file_not_exists_task = DummyOperator(task_id='file_not_exists',dag=dag)

get_gcs_object = BranchPythonOperator(
    task_id='get_gcs_object',
    python_callable=get_object_in_folder,
    op_kwargs={'folder_prefix':prefix_value},
    provide_context=True,
    dag=dag)

 
pipeline = CloudDataFusionStartPipelineOperator(
        task_id='start_datafusion_pipeline',
        location='us-central1', 
        project_id='aerobic-amphora-409013',
        instance_name='gcp-practice-df-95',
        pipeline_name='gcs_to_bq_df_pipeline',
        runtime_args={"FileName":"{{ti.xcom_pull(task_ids='get_gcs_object', key='file_name')}}"},
        success_states=['SUCCEEDED',PipelineStates.COMPLETED],
        pipeline_timeout=3600,
        dag=dag
    ) 

    
start_task >> get_gcs_object >> [pipeline, file_not_exists_task] >> end_task
