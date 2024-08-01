variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
