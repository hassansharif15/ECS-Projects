terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

########################################
# S3 Remote State Bucket
########################################

module "state_bucket" {
  source = "../modules/s3"

  bucket_name = var.state_bucket_name
  tags        = var.tags
}

########################################
# DynamoDB Lock Table
########################################

module "lock_table" {
  source = "../modules/dynamodb"

  table_name = var.lock_table_name
  tags       = var.tags
}
