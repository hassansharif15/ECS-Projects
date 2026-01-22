# 🔧 Terraform Bootstrap
### *Remote State Management + Distributed Locking*

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)
![S3](https://img.shields.io/badge/Amazon%20S3-FF9900?style=for-the-badge&logo=amazon-s3&logoColor=white)
![DynamoDB](https://img.shields.io/badge/DynamoDB-527FFF?style=for-the-badge&logo=amazon-dynamodb&logoColor=white)

</div>

---

## Overview

Provisions the foundational Terraform backend resources required for managing infrastructure state and preventing concurrent modifications. This must be run **once per AWS account/region** before deploying main infrastructure.

### What Gets Created

| Resource | Purpose | Features |
|----------|---------|----------|
|  **S3 State Bucket** | Terraform remote state storage | Versioning, encryption, public access blocked |
|  **S3 Log Bucket** | Access logs archive | Audit trail for compliance |
|  **DynamoDB Lock Table** | State locking mechanism | Prevents concurrent modifications |

---

## Architecture

```
Terraform/
├──  Bootstrap/
│   ├── main.tf              # Resource definitions
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Exported values
│   └── provider.tf          # AWS provider config
│
└── (main infrastructure in parent directory...)
```

---

## Why This Matters

<table>
<tr>
<td>

**Persistent State**
State safely stored in S3 outside your local machine

</td>
<td>

**Team Collaboration**
Multiple team members/pipelines can use the same state

</td>
</tr>
<tr>
<td>

**Concurrent Safety**
DynamoDB locking prevents state corruption from overlapping runs

</td>
<td>

**Audit Trail**
Versioning and logging for compliance and troubleshooting

</td>
</tr>
</table>

---

##  Quick Start

### Step 1: Navigate to Bootstrap

```bash
cd Terraform/Bootstrap
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Apply Bootstrap Resources

```bash
terraform apply -auto-approve
```

 **Backend resources are now ready!**

---

## ⚙️ Configure Main Terraform Backend

After Bootstrap completes successfully, update your main Terraform configuration.

**File:** `Terraform/backend.tf`

```hcl
terraform {
  backend "s3" {
    bucket         = "your-state-bucket-name"
    key            = "state/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "your-lock-table-name"
    encrypt        = true
  }
}
```

Then reconfigure the main backend:

```bash
cd ../
terraform init -reconfigure
```

---

##  Resource Details

###  DynamoDB Lock Table

Used for distributed state locking across team/pipeline executions.

```
Billing Mode:  PAY_PER_REQUEST
Partition Key: LockID (String)
Purpose:       Ensures only one operation modifies state at a time
```

###  S3 Log Bucket

Stores access logs from the state bucket for compliance auditing.

**Configuration:**
-  Server-side encryption
-  Lifecycle policies for old logs
-  Versioning (optional)

### 3 S3 State Bucket

Primary Terraform state storage with security hardening.

**Configuration:**
-  Versioning enabled
-  AES-256 encryption enabled
-  Public access blocked
-  Access logging enabled
-  MFA delete (recommended)

---

## Module Variables

Configure these in `terraform.tfvars`:

| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `region` | string | AWS region | `eu-west-2` |
| `environment` | string | Environment label | `dev`, `staging`, `prod` |
| `state_bucket_name` | string | State bucket name | `myproject-terraform-state` |
| `log_bucket_name` | string | Log bucket name | `myproject-terraform-logs` |
| `lock_table_name` | string | DynamoDB table name | `myproject-terraform-locks` |

---

## Multi-Environment Setup

### Strategy 1: Separate Buckets per Environment
```
prod-terraform-state
staging-terraform-state
dev-terraform-state
```
**Pros:** Maximum isolation | **Cons:** More resources

### Strategy 2: Separate Keys per Environment
```
s3://terraform-state/prod/terraform.tfstate
s3://terraform-state/staging/terraform.tfstate
s3://terraform-state/dev/terraform.tfstate
```
**Pros:** Single bucket, lower costs | **Cons:** Less isolation

---

## Critical Best Practices

### Do NOT Commit These Files
```
❌ .terraform/
❌ .tfstate
❌ .tfstate.backup
❌ terraform.tfvars
```

### Preserve Bootstrap Resources
> **Never destroy** Bootstrap resources unless intentionally tearing down the entire environment. Destruction removes your state storage and breaks all Terraform operations.

### Access Control
- Restrict S3 bucket access via IAM policies
- Enable MFA delete on state bucket
- Use bucket versioning for recovery

---

## Common Commands

```bash
cd Terraform

# Format all Terraform code
terraform fmt -recursive

# Initialize working directory
terraform init

# Validate Terraform files
terraform validate

# Preview infrastructure changes
terraform plan

# Apply changes (with approval)
terraform apply

# Destroy infrastructure (dangerous!)
terraform destroy
```

---

## Useful AWS CLI Commands

### Check S3 Buckets
```bash
aws s3 ls --region eu-west-2
aws s3api head-bucket --bucket <bucket-name> --region eu-west-2
```

### Check DynamoDB Table
```bash
aws dynamodb describe-table --table-name <table-name> --region eu-west-2
```

### Monitor State Files
```bash
aws s3 ls s3://<bucket-name>/state/ --recursive --region eu-west-2
```

---

<div align="center">

 **Bootstrap is ready to support your infrastructure** 

</div>

