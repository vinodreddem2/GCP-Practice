from google.cloud import pubsub_v1


project_id = "refined-kite-408510"
topic_name = "gcp-practice-topic1"


publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_name)

data = '{"a":"1"}'

# Data must be a bytestring
data = data.encode("utf-8")

# When you publish a message, the client returns a future.
future = publisher.publish(topic_path, data=data)
print(future.result())