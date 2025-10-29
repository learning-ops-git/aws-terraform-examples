module "jobs" {
  providers = {
    aws.main = aws.main
  }

  source                     = "../mod-glue-job"
  for_each                   = local.glue_jobs_definition
  country                    = var.country
  env                        = var.env
  capacity                   = var.capacity
  integrity                  = var.integrity
  confidentiality            = var.confidentiality
  tags                       = local.glue_job_tags
  job_name                   = each.value.job_name
  job_parameters             = each.value.job_parameters
  script_path                = each.value.script_path
  bucket_deployment          = each.value.bucket_deployment
  role_name                  = each.value.role_name
}