import json


def lambda_handler(event, context):
    """
    AWS Lambda handler that prints the incoming event and the Lambda context details.
    """
    silver_path = "s3://my-bucket/silver/"
    try:
        event_str = json.dumps(event, default=str)
    except Exception:
        event_str = str(event)


    return {"status": "ok"}