import boto3
from route_utils.utils import *

SILVER_BUCKET = "co-data-engineering-216461881627-dev-silver"
s3 = boto3.client("s3")

def change_bucket(s3_route: S3Route) -> S3Route:
    return S3Route(bucket=SILVER_BUCKET, key=s3_route.key)

def change_key_prefix(s3_route: S3Route) -> S3Route:
    old_key = s3_route.key
    name, year, month, day = old_key.split("_", 4)
    new_key = f"{name}/year={year}/month={month}/day={day}/{old_key}"
    return S3Route(bucket=s3_route.bucket, key=new_key)

def main(event, context):
    """
    AWS Lambda handler that prints the incoming event and the Lambda context details.
    """
    
    src_route = EventParser.parse_s3_event(event)
    target_route = S3RouteMapper.map_src_to_dest(src_route, [change_bucket, change_key_prefix])
    
    s3.copy_object(
        Bucket=target_route.bucket,
        Key=target_route.key,
        CopySource={"Bucket": src_route.bucket, "Key": src_route.key}
    )

    s3.delete_object(
        Bucket=src_route.bucket,
        Key=src_route.key
    )

    return {"status": "ok"}