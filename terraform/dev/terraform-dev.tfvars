country = "co"

env = "dev"

job_parameters = {
  "--PROCESS_DATE"              = ""
  "--data_quality"              = "summary"
  "--enable-glue-datacatalog"   = "true"
}


glue_jobs_tags = {
  integrity          = "critical",
  confidentiality    = "confidential",
  information-domain = "productos",
  env : "dev"
}

