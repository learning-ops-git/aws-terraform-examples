variable "country" {
    description = "deployment country"
    type = string
    validation {
        condition = contains(["co"])
        error_message = "Invalid country"
    }
    nullable = false
}

variable "env" {
    description = "AWS env"
    validation {
        condition = contains(["dev"])
        error_message = "Invalid env"
    }
    nullable = false
}

variable "tags" {
    description = ""
    type = map(string)
    nullable = true
    default = {}
}

variable "glue_version" {
    description = "Version of the glue job"
    type = string
    default = "5.0"
    nullable = false
}

variable "job_name" {
    description = ""
    type = string
    default = "5.0"
}

variable "role_arn" {
    description = "Job role"
    type = string
    nullable = false
}

variable "bucket_deployment" {
    description = "Bucket with the script"
    type = string
    nullable = false
}

variable "script_path" {
    description = "Path inside the bucket"
    type = string
    nullable = false
}

variable "job_parameters" {
  description = "Parametros del job, lista clave=valor."
  type        = map(string)
  default     = {}
}