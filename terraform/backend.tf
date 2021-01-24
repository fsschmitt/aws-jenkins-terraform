#Set S3 backend for persisting TF state file remotely,
# ensure bucket already exits
terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
  backend "s3" {
    bucket  = "tf-state-backend-990exrva" # DYNAMIC_S3_BUCKET_NAME
    region  = "us-east-1"
    profile = "default"
    key     = "terraformstatefile"
  }
}
