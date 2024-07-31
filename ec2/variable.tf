variable "instance_type" {
  type        = string // string, number, bool, list, map, set, object, tuple, any
  default     = "t2.micro"
  description = "Instance type of the EC2"

  validation {
    condition     = contains(["t2.micro", "t3.small"], var.instance_type)
    error_message = "The instance type not valid. Please choose t2.micro or t3.small"
  }
}
