# Terraform Setup

## Generate IAM policy, user and access key
In order to achieve this there are a couple of steps that need to be taken, that can be executed though `scripts/generate_iam.sh`.



## Steps
1. In order to be able to use terraform, it is required to create the IAM permissions for the account being used for terraform, in order to do so it is required to create a IAM policy.
```
aws iam create-policy --policy-name="terraformUserPolicy" --description="User Policy to be used by Terraform" --policy-document file://iam/policy-strict.json
```

2. Create the user account for Terraform (note `arn` based on previous step)
```
aws iam create-user --user-name="terraformuser" --permissions-boundary="arn:aws:iam::733487994826:policy/terraformUserPolicy" --tags='[ {"Key": "Name", "Value": "TFPolicy"} ]'
```

3. Generate user access key credentials
```
aws iam create-access-key --user-name="terraformuser"
```
