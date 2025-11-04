locals {

  bucket_properties = {
    persistent_storage = {
        storage_type = "persistent"
        buckets = [
            "bronce",
            "silver",
            "gold",
            "archive",
            "logs",
            "artifacts",
            "athena-results",
        ]
    },
    temp_storage = {
        storage_type = "temporary"
        buckets = [
            "landing",
        ]
    }
  }

  flattened_bucket_definitions = flatten([
    for property_key, property_value in local.bucket_properties : [
      for bucket in property_value.buckets : {
        suffix         = bucket 
        tags =  merge(
          var.tags,{
          storage_type = props_value.storage_type
          }
        )
      }
    ]
  ])

  bucket_defintions = {
    for bucket in local.flattened_bucket_definitions : 
        bucket.suffix => bucket
  }

  account_id = data.aws_caller_identity.current.account_id
}
