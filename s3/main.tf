provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-bucket-updated"

  tags = {
    Name = "terraform-bucket"
  }

}
