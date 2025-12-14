region            = "eu-west-2"
state_bucket_name = "hassan-tfstate-devopsbyhassan"
lock_table_name   = "app-tf-locks"

tags = {
  Project = "ecs-app"
  Owner   = "hassan"
  Env     = "bootstrap"
}
