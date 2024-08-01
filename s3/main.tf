terraform {
  required_version = "1.9.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-bucket-updated"

  tags = {
    Name = "terraform-bucket"
  }
}
