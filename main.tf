terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
    bucket = "lifedatabase-terraform-state"
    dynamodb_table = "terraform-lock-table"
    key    = "lifedatabase"
    region = "us-west-2"
    profile = "brownie"
  }
}

provider "aws" {
  profile = "brownie"
  region  = "us-west-2"
}

variable "cluster_name" {
  description = "Value of the name of the ECS Cluster"
  type        = string
  default     = "lifedatabase"
}

output "cluster_arn" {
  description = "ARN of the ecs_cluster"
  value       = aws_ecs_cluster.lifedatabase_ecs_cluster.arn
}

resource "aws_ecs_cluster" "lifedatabase_ecs_cluster" {
  name = var.cluster_name
}
