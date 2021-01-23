#!/bin/bash

# Create S3 bucket for tf state backend
read random_hash < <(echo $(tr -dc a-z0-9 </dev/urandom | head -c 8 ; echo ''))
echo "Creating the S3 bucket tf-state-backend-$random_hash"
aws s3api create-bucket --bucket "tf-state-backend-$random_hash"

# Export env and update .env file
export TF_VAR_backend_bucket_name="tf-state-backend-$random_hash"
sed -i "s|^TF_VAR_backend_bucket_name=.*$|TF_VAR_backend_bucket_name=$TF_VAR_backend_bucket_name|g" ${PROJECT_ROOT_DIR}/.env
