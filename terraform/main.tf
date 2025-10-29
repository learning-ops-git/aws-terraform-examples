module "jobs" {
  providers = {
    aws.main = aws.main
  }

  source                     = "./mod-glue-job"
  for_each                   = local.glue_jobs_definition
  country                    = var.country
  env                        = var.env
  tags                       = local.glue_job_tags
  job_name                   = each.value.job_name
  job_parameters             = each.value.job_parameters
  script_path                = each.value.script_path
  bucket_deployment          = each.value.bucket_deployment
  role_arn                   = each.value.role_arn
}