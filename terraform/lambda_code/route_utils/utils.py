class S3Route:

    def __init__(self, bucket: str, key: str):
        self.bucket = bucket
        self.key = key
        self.file_name = key.split("/")[-1].split(".")[0]
        self.file_extension = key.split(".")[-1] if "." in key else ""
    
    def to_s3_path(self) -> str:
        return f"s3://{self.bucket}/{self.key}"

class EventParser:

    @staticmethod
    def parse_s3_event(event: dict) -> S3Route:
        """
        Parses an S3 event dictionary to extract the bucket and key of the object involved in the event.
        Assumes the event follows the standard AWS S3 event structure.
        """
        try:
            records = event.get("Records", [])
            if not records:
                raise ValueError("No Records found in event")

            s3_info = records[0].get("s3", {})
            bucket = s3_info.get("bucket", {}).get("name")
            key = s3_info.get("object", {}).get("key")

            if not bucket or not key:
                raise ValueError("Bucket or Key information is missing in the event")

            return S3Route(bucket=bucket, key=key)

        except Exception as e:
            raise ValueError(f"Failed to parse S3 event: {e}")
        
class S3RouteMapper:

    @staticmethod
    def map_src_to_dest(src_route: S3Route, map_funcs: list) -> S3Route:
        """
        Maps a source S3Route to a destination S3Route using a list of mapping functions.
        Each mapping function takes an S3Route and returns a modified S3Route.
        """
        dest_route = src_route
        for func in map_funcs:
            dest_route = func(dest_route)
        return dest_route