import config
import json

from flask import Blueprint, jsonify, request
from google.cloud import pubsub_v1

publish_bp = Blueprint(name="publish_bp", import_name=__name__)

@publish_bp.route("/publish_data", methods=["POST"], strict_slashes=False)
def publish_message():
    try:

        request_body = request.get_json()

        project_id = "refined-kite-408510"
        topic_name = "gcp-practice-topic1"

        publisher = pubsub_v1.PublisherClient()
        topic_path = publisher.topic_path(project_id, topic_name)

        data = str(request_body)

        # Data must be a bytestring
        data = data.encode("utf-8")

        # When you publish a message, the client returns a future.
        future = publisher.publish(topic_path, data=data)
        print(future.result())

        response_body = {
            "message": "published successfully"
        }

        return jsonify(response_body), 200

    except Exception as error:

        response_body = {
            "message": "Error : {}".format(error),
        }

        return jsonify(response_body), 400