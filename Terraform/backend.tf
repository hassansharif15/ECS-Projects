terraform {
  required_version = ">= 1.5.0"



  backend "s3" {
    bucket         = "hassan-tfstate-devopsbyhassan"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "app-tf-locks"
    encrypt        = true
  }
}
