terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # Backend recomendado (S3 + DynamoDB). Ver backend-example.tf
}

provider "aws" {
  region = var.aws_region
}
