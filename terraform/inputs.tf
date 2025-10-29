# VARIABLES GLOBALES
variable "country" {
  description = "País de despliegue."
  type        = string
  validation {
    condition     = contains(["co", "pa", "gt", "ts"], var.country)
    error_message = "El país seleccionado no es valido, solo esta permitido: co, pa, gt, ts."
  }
  nullable = false
}

variable "env" {
  description = "Ambiente donde será desplegado el componente. Sus únicos valores posibles serán: dev, qa, pdn, sbx, acepta."
  type        = string
  validation {
    condition     = contains(["dev", "qa", "pdn", "sbx", "acepta"], var.env)
    error_message = "El ambiente seleccionado no es valido, solo esta permitido: dev, qa, pdn, sbx, acepta."
  }
  nullable = false
}

variable "glue_jobs_tags" {
  description = "Tags requeridos para los jobs de AWS Glue"
  type        = map(string)
}

variable "job_parameters" {
  type     = map(string)
  nullable = false
}
