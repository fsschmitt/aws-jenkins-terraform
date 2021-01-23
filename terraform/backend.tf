#Set S3 backend for persisting TF state file remotely, ensure bucket already exits
# And that AWS user being used by TF has read/write perms
terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
  backend "s3" {
    bucket  = "tf-state-backend-2ab6h8e0"
    region  = "us-east-1"
    profile = "default"
    key     = "terraformstatefile"
  }
}
