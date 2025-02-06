terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "my-tf-state-01022025"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "lambda_name" {
  type = string
}

variable "python_version" {
  type = string
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  handler       = "function.handler"
  runtime       = "python${var.python_version}"

  create_package         = false
  local_existing_package = "./package.zip"
}
