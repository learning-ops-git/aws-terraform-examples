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
  
  custom_bucket_properties = {
    "landing" = {
      s3_notifications = {
        enable_lambda = true
        lambda = [
          {
            function_name = data.aws_lambda_function.lambda_function.function_name
            arn    = data.aws_lambda_function.lambda_function.arn
            events = ["s3:ObjectCreated:*"]
          }
           ]
        }
      }
  }

  flattened_bucket_definitions = flatten([
    for property_key, property_value in local.bucket_properties : [
      for bucket in property_value.buckets : {
        suffix         = bucket 
        tags =  merge(
          var.tags,{
          storage_type = property_value.storage_type
          custom_bucket_properties = lookup(
            local.custom_bucket_properties,
            bucket,
            { s3_notifications = {enable_lambda = false, lambda = [] }})
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
