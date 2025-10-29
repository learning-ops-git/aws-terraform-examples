locals {
    resource_tags = merge(var.tags, {})

    job_tags = merge (
        {
            domain = "data"
        },
        local.resource_tags
    )

    argument_auto = {
        "--ENV"                              = var.env
        "--enable-metrics"                   = "true"
        "--enable-glue-datacatalog"          = "true"
        "--enable-continuous-cloudwatch-log" = "true"
        "--job-language"                     = "python"
        "--TempDir"                          = "s3://${var.bucket_deployment}/temporary/${var.job_name}/"
    }

    job_arguments = merge(local.argument_auto, var.job_parameters)
}

