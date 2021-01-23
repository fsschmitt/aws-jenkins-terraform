#!/bin/bash

export AWS_IAM_TERRAFORM_POLICY_NAME="tfuserpolicy"
export AWS_IAM_TERRAFORM_USER_NAME="tfuser"

# # Create terraform user policy
read policy_arn < <(echo $(aws iam create-policy --policy-name=${AWS_IAM_TERRAFORM_POLICY_NAME} --description="User Policy to be used by Terraform" --policy-document file://${PROJECT_ROOT_DIR}/terraform/iam/policy-strict.json | jq -r ".Policy.Arn"))
export AWS_IAM_TERRAFORM_POLICY_ARN=$policy_arn

# Creat terraform user
aws iam create-user --user-name=${AWS_IAM_TERRAFORM_USER_NAME} --permissions-boundary=${AWS_IAM_TERRAFORM_POLICY_ARN} --tags='[ {"Key": "Name", "Value": "TFPolicy"} ]'

# Create terraform user access keys
read access_key_id access_key_secret < <(echo $(aws iam create-access-key --user-name ${AWS_IAM_TERRAFORM_USER_NAME} | jq -r ".AccessKey.AccessKeyId, .AccessKey.SecretAccessKey"))
export AWS_IAM_TERRAFORM_ACCESS_KEY_ID=$access_key_id
export AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=$access_key_secret

# Update .env file with credentials
sed -i "s|^AWS_IAM_TERRAFORM_POLICY_ARN=.*$|AWS_IAM_TERRAFORM_POLICY_ARN=${AWS_IAM_TERRAFORM_POLICY_ARN}|g" ${PROJECT_ROOT_DIR}/.env
sed -i "s|^AWS_IAM_TERRAFORM_ACCESS_KEY_ID=.*$|AWS_IAM_TERRAFORM_ACCESS_KEY_ID=${AWS_IAM_TERRAFORM_ACCESS_KEY_ID}|g" ${PROJECT_ROOT_DIR}/.env
sed -i "s|^AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=.*$|AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=${AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET}|g" ${PROJECT_ROOT_DIR}/.env
