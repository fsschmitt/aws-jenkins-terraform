# Terraform Setup

In order to streamline the experience in this project, the easiest way to develop is through the usage of the [cloud-sdk-container](https://github.com/fsschmitt/cloud-sdk-container) created by [@fsschmitt](https://github.com/fsschmitt).

### Pre-requirement

- Have docker engine installed and running;
- AWS account with `.env` for `AWS_ACCESS_KEY_ID` and  `AWS_SECRET_ACCESS_KEY`
- Fill the variable for Number of Jenkins Workers, DNS Hosted Zones
  - Note: If using a cloud sandbox, Route53 Hosted Zone name can be automatically fetched throug [this script](scripts/collect_route53_hosted_zones.sh)
### Development environment

In the main folder (parent folder), execute the following command:
```
make run
```

It will deploy a ephemeral container with the image [cloud-sdk-container](https://hub.docker.com/r/fsschmitt/cloud-sdk-container) that has all tools needed for this.

Then go through the following steps to generate the initial pre-requirements to have Terraform ready to be deployed in your AWS account.

#### Run the initilizer script
```
. scripts/init.sh
```
This will execute implicitly the following steps:

##### Generate IAM policy, user and access key
In order to achieve this there are a couple of steps that need to be taken, that can be executed though `scripts/generate_iam.sh`.

This script will generate the IAM Policy, User and create an access key and add it to your `.env` file under the variables:
```
AWS_IAM_TERRAFORM_POLICY_ARN=
AWS_IAM_TERRAFORM_ACCESS_KEY_ID=
AWS_IAM_TERRAFORM_ACCESS_KEY_SECRET=
```

##### Generate S3 bucket for the Terraform backend
In order to achieve this, run the script `scripts/generate_state_bucket.sh`, then the backend can be initilized by:

1. Updating the file [backend.tf](./backend.tf) to include the bucket name just created;
2. Run the following command:
```
terraform init
```

##### Generate SSH key-pair
Generate an SSH key-pair to be deployed in ec2 instances to enable SSH into them after deployment, through the script `scripts/generate_ssh_key.sh`.

# Terraform usage

```
# Format terraform files
terraform fmt

# Plan terraform resources to be deployed
terraform plan

# Apply terraform
terraform apply
```
