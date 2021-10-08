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

resource "aws_iam_instance_profile" "spot_instance_profile" {
  name = "spot_instance_profile"
  role = aws_iam_role.spot_instance_role.name
}

resource "aws_iam_role" "spot_instance_role" {
  name = "spot_instance_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_security_group" "spot_instance_access" {
  name        = "spot_instance_access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from Home"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_spot_fleet_request" "cheap_compute" {
  iam_fleet_role      = "arn:aws:iam::662430452979:role/aws-ec2-spot-fleet-role"
  spot_price          = "0.0105"
  allocation_strategy = "diversified"
  target_capacity     = 1
  terminate_instances_with_expiration = true

  launch_specification {
    instance_type            = "c5.xlarge"
    ami                      = "ami-0ca5c3bd5a268e7db"
    spot_price               = "0.0660"
    availability_zone        = "us-west-2a"
    subnet_id                = aws_subnet.main.id
    key_name                 = "personal-uswest2"
    iam_instance_profile_arn = aws_iam_instance_profile.spot_instance_profile.arn
    vpc_security_group_ids   = [aws_security_group.spot_instance_access.id]
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  availability_zone        = "us-west-2a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
}