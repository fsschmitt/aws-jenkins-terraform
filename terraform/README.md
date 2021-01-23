# Terraform Setup

## Generate IAM policy, user and access key
In order to achieve this there are a couple of steps that need to be taken, that can be executed though `scripts/generate_iam.sh`.

This script will generate the IAM Policy, User and create an access key and add it to your `.env` file under the variables:
```
AWS_IAM_TERRAFORM_POLICY_ARN=
AWS_IAM_TERRAFORM_ACCESS_KEY_ID=
AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=
```
