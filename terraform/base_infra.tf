terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "brownie"
  region  = "us-west-2"
}

resource "aws_s3_bucket" "tfstate-bucket" {
  bucket = "lifedatabase-terraform-state"
  acl    = "private"
}

resource "aws_dynamodb_table" "terraform-lock-table" {
  name           = "terraform-lock-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}