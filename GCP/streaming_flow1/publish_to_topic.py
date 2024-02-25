import logging
import apache_beam as beam

from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.metrics import Metrics

class MyOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_value_provider_argument(
            '--project_name',
            default='',
            type=str,
            required=False,
            help='project id.')

        parser.add_value_provider_argument(
            '--topic_name',
            default='',
            type=str,
            required=False,
            help='Input topic id ')


class generate_data(beam.DoFn):

    def process(self,element):
        import datetime
        import time
        from faker import Faker

        fake = Faker()

        while True:
            sample_data = {
                'create_time': datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S"),
                'name': fake.name(),
                'email': fake.email(),
                'address': fake.address(),
                'phone_number': fake.phone_number()
            }
            time.sleep(30)
            logging.info(f"sample_data : {sample_data}")
            yield sample_data


class publish_to_pubsub(beam.DoFn):

    def __init__(self, project_id, topic_id):
        self.project_id = project_id
        self.topic_id = topic_id
        self.publish_count = Metrics.counter(self.__class__, 'publish_count')

    def process(self,element):
        import json
        from google.cloud import pubsub_v1


        logging.info(f"project : {self.project_id.get()} , topic : {self.topic_id.get()}")
        
        publisher = pubsub_v1.PublisherClient()
        topic_path = publisher.topic_path(self.project_id.get() , self.topic_id.get())
        data = json.dumps(element).encode('utf-8')
        
        future = publisher.publish(topic_path, data)
        logging.info(f"Published {data} to {topic_path}. Message ID: {future.result()}")
        self.publish_count.inc()

def run():

    myoptions = PipelineOptions().view_as(MyOptions)
    p = beam.Pipeline(options=myoptions)

    random_msgs = (p
                    | 'Start' >> beam.Create(['sample'])
                    | 'GenerateData' >> beam.ParDo(generate_data())
                )
    
    random_msgs | 'WriteToPubSub' >> beam.ParDo(publish_to_pubsub(myoptions.project_name, myoptions.topic_name))
     

    result = p.run()
    result.wait_until_finish()


if __name__ == '__main__':
    run()
