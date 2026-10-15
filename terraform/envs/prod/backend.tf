terraform {
  backend "s3" {
    bucket       = "banking-tfstate-641628981671-ap-south-1"
    key          = "envs/prod/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
