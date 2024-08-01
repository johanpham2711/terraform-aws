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

resource "aws_s3_bucket" "static" {
  bucket        = "my-static-web-bucket-1234"
  force_destroy = true

  tags = {
    Name = "my-static-web-bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "static" {
  bucket = aws_s3_bucket.static.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static" {
  bucket = aws_s3_bucket.static.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static" {
  depends_on = [
    aws_s3_bucket.static,
    aws_s3_bucket_ownership_controls.static,
    aws_s3_bucket_public_access_block.static,
  ]

  bucket = aws_s3_bucket.static.id
  acl    = "public-read"

}

resource "aws_s3_bucket_website_configuration" "static" {
  bucket = aws_s3_bucket.static.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "static" {
  depends_on = [
    aws_s3_bucket.static,
    aws_s3_bucket_ownership_controls.static,
    aws_s3_bucket_public_access_block.static,
    aws_s3_bucket_acl.static,
    aws_s3_bucket_website_configuration.static,
  ]

  bucket = aws_s3_bucket.static.id
  policy = file("s3_static_policy.json")
}

locals {
  mime_types = {
    html  = "text/html"
    css   = "text/css"
    ttf   = "font/ttf"
    woff  = "font/woff"
    woff2 = "font/woff2"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
    jpg   = "image/jpeg"
    png   = "image/png"
    svg   = "image/svg+xml"
    eot   = "application/vnd.ms-fontobject"
  }
}

resource "aws_s3_object" "object" {
  for_each     = fileset(path.module, "static-web/**/*")
  bucket       = aws_s3_bucket.static.id
  key          = replace(each.value, "static-web", "")
  source       = each.value
  etag         = filemd5(each.value)
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
