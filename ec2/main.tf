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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "terraform-test-instance" {
  #   ami           = "ami-09b80ee40b23aa576"
  #   ami           = "ami-012c2e8e24e2ae21d"
  count         = 5
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    Name = "terraform-test-instance"
  }
}

output "ec2" {
  value = { for index, instance in aws_instance.terraform-test-instance : format("public_ip#%s", index) => instance.public_ip }
}
