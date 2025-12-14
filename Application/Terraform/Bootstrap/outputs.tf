output "state_bucket_name" {
  value = module.state_bucket.bucket_name
}

output "lock_table_name" {
  value = module.lock_table.table_name
}
