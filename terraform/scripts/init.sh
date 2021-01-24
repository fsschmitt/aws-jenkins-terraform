#!/bin/bash

Generate SSH pair key
. ${PROJECT_ROOT_DIR}/terraform/scripts/generate_ssh_key.sh

# Create the IAM policy, user and access keys
. ${PROJECT_ROOT_DIR}/terraform/scripts/generate_iam.sh

# Create S3 bucket for Terraform State
. ${PROJECT_ROOT_DIR}/terraform/scripts/generate_state_bucket.sh
