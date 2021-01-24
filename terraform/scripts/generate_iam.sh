#!/bin/bash

# Create terraform user policy
if [[ -z "${AWS_IAM_TERRAFORM_POLICY_ARN}" ]]; then
  echo "[NEW] Creating terraform user policy in AWS .."
  read policy_arn < <(echo $(aws iam create-policy --policy-name=${AWS_IAM_TERRAFORM_POLICY_NAME} --description="User Policy to be used by Terraform" --policy-document file://${PROJECT_ROOT_DIR}/terraform/iam/policy-strict.json | jq -r ".Policy.Arn"))
  echo "[INFO] Created user policy with arn: ${policy_arn}"
  export AWS_IAM_TERRAFORM_POLICY_ARN=$policy_arn
  echo "[INFO] Updating .env file with the policy arn .."
  sed -i "s|^AWS_IAM_TERRAFORM_POLICY_ARN=.*$|AWS_IAM_TERRAFORM_POLICY_ARN=${AWS_IAM_TERRAFORM_POLICY_ARN}|g" ${PROJECT_ROOT_DIR}/.env
else
  echo "[INFO] Using Policy arn already defined by environment variable: ${AWS_IAM_TERRAFORM_POLICY_ARN}"
fi


# Creat terraform user
if ! aws iam get-user --user-name ${AWS_IAM_TERRAFORM_USER_NAME} > /dev/null 2>&1; then
  echo "[NEW] Creating terraform user in AWS .."
  aws iam create-user --user-name=${AWS_IAM_TERRAFORM_USER_NAME} --permissions-boundary=${AWS_IAM_TERRAFORM_POLICY_ARN} --tags='[ {"Key": "Name", "Value": "TFPolicy"} ]'
else
  echo "[INFO] User ${AWS_IAM_TERRAFORM_USER_NAME} already exists, proceeding .."
fi

# Create terraform user access keys
if [[ -z "${AWS_IAM_TERRAFORM_ACCESS_KEY_ID}" ]]; then
  echo "[NEW] Creating terraform user access keys .."
  read access_key_id access_key_secret < <(echo $(aws iam create-access-key --user-name ${AWS_IAM_TERRAFORM_USER_NAME} | jq -r ".AccessKey.AccessKeyId, .AccessKey.SecretAccessKey"))
  export AWS_IAM_TERRAFORM_ACCESS_KEY_ID=$access_key_id
  export AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=$access_key_secret
  echo "[INFO] Updating .env file with the access credentials .."
  sed -i "s|^AWS_IAM_TERRAFORM_ACCESS_KEY_ID=.*$|AWS_IAM_TERRAFORM_ACCESS_KEY_ID=${AWS_IAM_TERRAFORM_ACCESS_KEY_ID}|g" ${PROJECT_ROOT_DIR}/.env
  sed -i "s|^AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=.*$|AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=${AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET}|g" ${PROJECT_ROOT_DIR}/.env
else
  echo "[INFO] Terraform user access keys are already defined by environment variable for id: ${AWS_IAM_TERRAFORM_ACCESS_KEY_ID}"
fi

source ${PROJECT_ROOT_DIR}/.env
