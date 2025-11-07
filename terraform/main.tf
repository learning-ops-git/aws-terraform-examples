module "s3_buckets" {
  providers = {
    aws.main = aws.main
  }

  source = "github.com/learning-ops-git/terraform-modules//module/s3?ref=s3-module"
  for_each = local.bucket_defintions
  country = var.country
  domain = var.domain
  account_id = local.account_id
  environment = var.environment
  suffix = each.value.suffix
  owner = var.owner
  tags = each.value.tags
  s3_notifications = local.s3_notifications
}