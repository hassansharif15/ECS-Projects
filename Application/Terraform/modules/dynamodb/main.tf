########################################
# DynamoDB Table (Terraform State Locking)
########################################

resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.enable_pitr
  }

  tags = merge(var.tags, {
    Name = var.table_name
  })
}
