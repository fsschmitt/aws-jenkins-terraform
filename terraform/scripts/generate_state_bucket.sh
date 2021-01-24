#!/bin/bash

if [[ -z "${AWS_S3_TERRAFORM_BACKEND_NAME}" ]]; then
  # Create S3 bucket for tf state backend
  read random_hash < <(echo $(tr -dc a-z0-9 </dev/urandom | head -c 8 ; echo ''))
  echo "[NEW] Creating the S3 bucket tf-state-backend-$random_hash .."
  aws s3api create-bucket --bucket "tf-state-backend-$random_hash"

  # Export env and update .env file
  echo "[INFO] Exporting environment variables and update .env file .."
  export AWS_S3_TERRAFORM_BACKEND_NAME="tf-state-backend-$random_hash"
  sed -i "s|^AWS_S3_TERRAFORM_BACKEND_NAME=.*$|AWS_S3_TERRAFORM_BACKEND_NAME=$AWS_S3_TERRAFORM_BACKEND_NAME|g" ${PROJECT_ROOT_DIR}/.env
else
  echo "[INFO] Using S3 bucket already defined by environment variable: ${AWS_S3_TERRAFORM_BACKEND_NAME}"
fi

# Update backend.tf file with S3 bucket name
echo "[INFO] Updating backend.tf bucket name to ${AWS_S3_TERRAFORM_BACKEND_NAME} .."
sed -i "s|.*# DYNAMIC_S3_BUCKET_NAME|    bucket  = \"${AWS_S3_TERRAFORM_BACKEND_NAME}\" # DYNAMIC_S3_BUCKET_NAME|g" ${PROJECT_ROOT_DIR}/terraform/backend.tf

source ${PROJECT_ROOT_DIR}/.env
