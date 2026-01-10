output "log_bucket_name" {
  description = "S3 log bucket name."
  value       = aws_s3_bucket.log_bucket.bucket
}

output "state_bucket_name" {
  description = "S3 state bucket name (use this in your backend config)."
  value       = aws_s3_bucket.state_bucket.bucket
}

output "state_bucket_arn" {
  description = "ARN of the S3 state bucket."
  value       = aws_s3_bucket.state_bucket.arn
}

output "lock_table_name" {
  description = "DynamoDB lock table name (use this in your backend config)."
  value       = aws_dynamodb_table.tf_locks.name
}

output "lock_table_arn" {
  description = "ARN of the DynamoDB lock table."
  value       = aws_dynamodb_table.tf_locks.arn
}

output "region" {
  description = "AWS region used for bootstrap resources."
  value       = var.region
}
