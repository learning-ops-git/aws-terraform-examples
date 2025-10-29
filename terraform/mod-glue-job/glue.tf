resource "aws_glue_job" "main" {
    provider = aws.main
    name = var.job_name
    role_arn = var.role_arn
    glue_version = var.glue_version

    command {
        name = "glueetl"
        script_location = "s3://${var.bucket_deployment}/${var.script_path}/${var.job_name}.py"
    }
    default_arguments = local.job_arguments
    tags = local.job_tags
}