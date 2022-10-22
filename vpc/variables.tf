variable "aws_region" {
  description = "Region for the VPC"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "126.6.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  default     = 1
}

variable "private_subnet_count" {
  description = "Number of public subnets"
  default     = 1
}