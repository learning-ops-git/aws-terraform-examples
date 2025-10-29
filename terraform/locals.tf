locals {
  base_tags = {
    country      = var.country
    env          = var.env
  }

  glue_job_tags = merge(local.base_tags, {
    functionality = "curado"
  }, var.glue_jobs_tags)

  glue_jobs_properties = {
    transformar = {
      type_process = "transformar"
      jobs = [
        "example",
      ]
    }
    exportar = {
      type_process = "exportar"
      jobs = [
        "reportes",
      ]
    }
  }
  custom_parameters = {
    "example" = {
      "--DAYS_TO_PROCESS" = "180"
    }
    "exportar" = {
      "--DAYS_TO_PROCESS" = "180"
    }
  }

  mesh_env = var.env == "qa" ? "qc" : var.env

  flatten_jobs_definition = flatten([
    for glue_jobs_properties_key, props in local.glue_jobs_properties : [
      for job in props.jobs : {
        functionality        = job
        type_process         = props.type_process
        job_name             = "${var.country}_${props.type_process}_${job}"
        extra_job_parameters = can(local.custom_parameters[job]) ? local.custom_parameters[job] : {}
      }
    ]
  ])

  glue_jobs_definition = {
    for props in local.flatten_jobs_definition :

    props.job_name => {
      functionality              = props.functionality
      type_process               = props.type_process
      job_parameters             = merge(var.job_parameters, { "--ACCOUNT" = data.aws_caller_identity.current.account_id, "--ENV" : local.mesh_env }, props.extra_job_parameters)
      job_name                   = props.job_name
      script_path                = "Demo_Job.py"
      bucket_deployment          = "s3://aws-glue-assets-216461881627-us-east-1/scripts/"
      role_arn                  = "arn:aws:iam::216461881627:role/glue-role"
    }
  }

}
