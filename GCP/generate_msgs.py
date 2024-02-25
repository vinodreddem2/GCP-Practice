import random
import string
import time
import time
import json
import os
from google.cloud import pubsub_v1

def random_string(length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))


def random_msg():
    return {
        'type': random_string(10),
        'id': random.randint(1, 999),
        'duration':random.randint(1, 999)
        
    }


# os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "refined-kite-408510-7aecc1978511.json"

topic = 'projects/refined-kite-408510/topics/sample-test'

publisher = pubsub_v1.PublisherClient()


while True:
        msg = random_msg()
        message = json.dumps(msg)
        print(message)
        publisher.publish(topic, message.encode("utf-8"))
        print('Message published.')
        time.sleep(2)