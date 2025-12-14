output "bucket_id" {
  description = "Bucket ID"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "Bucket name"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_region" {
  description = "Bucket region"
  value       = aws_s3_bucket.this.region
}

output "public_access_block_id" {
  description = "ID of the Public Access Block configuration."
  value       = aws_s3_bucket_public_access_block.this.id
}

output "versioning_status" {
  description = "Versioning status for the bucket."
  value       = aws_s3_bucket_versioning.this.versioning_configuration[0].status
}

output "sse_algorithm" {
  description = "Server-side encryption algorithm configured for the bucket."
  value       = aws_s3_bucket_server_side_encryption_configuration.this.rule[0].apply_server_side_encryption_by_default[0].sse_algorithm
}