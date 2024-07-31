provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "terraform-test-instance" {
#   ami           = "ami-09b80ee40b23aa576"
  ami           = "ami-012c2e8e24e2ae21d"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-test-instance"
  }

}
