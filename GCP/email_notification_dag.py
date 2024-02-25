from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.dummy import DummyOperator
from airflow.operators.python_operator import PythonOperator, BranchPythonOperator
from airflow.operators.email import EmailOperator


# Define default_args dictionary to set the default parameters for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 18),
    'email_on_failure': True,
    'email':['reddysekhar0295@gmail.com'],
    'email_on_retry': False,
    'retries':0
}


def error_function():
    raise Exception('Something wrong')

#def on_failure_callback(context):
#    subject = f"Airflow alert: {context['task_instance'].task_id} failed"
#    body = (
#        f"Task failed, details:\n\n"
#        f"DAG: {context['dag'].dag_id}\n"
#        f"Task: {context['task_instance'].task_id}\n"
#        f"Execution Time: {context['execution_date']}\n"
#    )
#
#    # Send email
#    EmailOperator(
#        task_id='send_failure_email',
#        to=['reddythummala3@gmail.com'],
#        subject=subject,
#        html_content=body,
#    ).execute(context=context)



# Create a DAG object
dag = DAG(
    'example_email_dag',
    default_args=default_args,
    description='An example Airflow dag for email notification',
    schedule_interval=None,
    )


    
start_task = DummyOperator(task_id='start',dag=dag)
    
end_task = DummyOperator(task_id='end', dag=dag)

task1 = PythonOperator(
    task_id='task1',
    python_callable=error_function,
    email=["reddysekhar0295@gmail.com"],
    email_on_failure=True,
    dag=dag)

    
start_task >> task1 >> end_task
