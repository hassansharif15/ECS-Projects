## Terraform Bootstrap (Remote State + Locking)

This Bootstrap module provisions the Terraform backend resources required for the rest of the project:

S3 state bucket — stores Terraform remote state (terraform.tfstate)

S3 log bucket — stores access logs for the state bucket

DynamoDB lock table — prevents concurrent Terraform runs corrupting state

Run this once per AWS account/region (or per environment if you separate environments).

```text
Terraform/
├── Bootstrap/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
└── (main infrastructure files...)
```


### S3

Bucket for Terraform state

Recommended settings:

Versioning enabled

Encryption enabled

Public access blocked

### DynamoDB

Lock table with:

Partition key: LockID (String)

PAY_PER_REQUEST billing (recommended)

## Why this exists

Terraform remote state is critical for real deployments:

State persists safely outside your local machine

Multiple people/pipelines can use the same state

DynamoDB locking prevents state corruption from overlapping runs



## How to run Bootstrap (Manual)

Run this once before your main Terraform.

1) Move into the Bootstrap folder:
cd Terraform/Bootstrap

2) Initialise Terraform:
terraform init

3) Apply
terraform apply -auto-approve

## Configure the main Terraform backend

After Bootstrap is applied, configure your main Terraform backend in Terraform/backend.tf
terraform {
  backend "s3" {
    bucket         = "<STATE_BUCKET_NAME>"
    key            = "state/terraform.tfstate"
    region         = "<AWS_REGION>"
    dynamodb_table = "<LOCK_TABLE_NAME>"
    encrypt        = true
  }
}

Then run in your main Terraform folder:
cd ../
terraform init -reconfigure



Resources Created
1) DynamoDB Lock Table

A DynamoDB table used for state locking:

Billing mode: PAY_PER_REQUEST

Hash key: LockID (String)

Terraform uses this lock to ensure only one plan/apply/destroy can modify state at a time.

2) S3 Log Bucket

S3 bucket for logging (used to store state bucket access logs).

3) S3 State Bucket

S3 bucket used as the Terraform backend (remote state storage).
Typically configured with:

Encryption enabled

Block public access

Logging enabled (to the log bucket)

## Inputs (variables)

This module expects these variables (see variables.tf):

region (string) — AWS region to deploy into

environment (string) — environment label (e.g. dev, staging, prod)

log_bucket_name (string) — name for the S3 log bucket

state_bucket_name (string) — name for the Terraform state S3 bucket

lock_table_name (string) — DynamoDB lock table name

---

Notes / Best Practice

Do not commit .terraform/, .tfstate, or terraform.tfvars

The Bootstrap backend resources should generally not be destroyed unless you are intentionally tearing down the entire environment (it removes your state storage)

If you use multiple environments, use:

separate buckets per env, or

separate state keys per env (dev/terraform.tfstate, prod/terraform.tfstate)

## Local Terraform Commands 
```text
cd Terraform
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

