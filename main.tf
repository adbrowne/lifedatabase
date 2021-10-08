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

resource "aws_ecs_task_definition" "api" {
  family = "api"
  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "662430452979.dkr.ecr.us-west-2.amazonaws.com/lifedatabase-api:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
        }
      ]
    }
  ])

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

resource "aws_iam_role" "lifedatabase-api" {
  name = "lifedatabase-api-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = aws_ecs_cluster.lifedatabase_ecs_cluster.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 1
  iam_role        = aws_iam_role.lifedatabase-api.arn
  depends_on      = [aws_iam_role_policy.lifedatabase-api]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lifedatabase-api.arn
    container_name   = "api"
    container_port   = 9000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
