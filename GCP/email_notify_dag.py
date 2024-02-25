from datetime import datetime

import airflow
from airflow.operators.email import EmailOperator
from airflow.operators.dummy import DummyOperator



default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 22),
    'email_on_failure': True,
    'email_on_retry': False,
    'retries':0
}

with airflow.DAG(
    "email_sample_sendgrid",
    default_args = default_args,
    schedule = None
) as dag:

    start_task = DummyOperator(task_id='start',dag=dag)
    
    end_task = DummyOperator(task_id='end', dag=dag)
    
    task_email = EmailOperator(
        task_id="send-email",
        conn_id="sendgrid_default",
        to=["reddythummala3@gmail.com","reddysekhar0295@gmail.com"],
        subject="EmailOperator test for SendGrid",
        html_content="This is a test message sent through SendGrid.",
        dag=dag,
    )
    
    start_task >> task_email >> end_task