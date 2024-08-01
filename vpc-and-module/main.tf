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

module "vpc" {
  source = "./vpc"

  vpc_cidr_block             = "10.0.0.0/16"
  private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnet_cidr_blocks  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones         = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
