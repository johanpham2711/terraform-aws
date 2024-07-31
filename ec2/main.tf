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
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-test-instance"
  }

}
