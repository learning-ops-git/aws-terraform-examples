terraform {
  cloud {
    organization = "learning-ops-git"

    workspaces {
      name = "s3-module-dev"
    }
  }
}
