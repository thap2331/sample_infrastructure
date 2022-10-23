variable "instance_type" {
    default = "t1.micro"
}

variable "ami_id" {
  default     = "ami-0c09c7eb16d3e8e70"
  description = "Ubuntu 20.04"
}

variable "ec2_count" {
  default = "1"
}

variable "subnet_id" {}

variable "public_access" {
  default = true
}

variable "keypair" {
  #Generate in aws once and share .pem key using lastpass/onepass or other mechanism
  default = "test_kp"
}

variable "vpc_security_group_ids" {
  default = ["default"]
}

variable "user_data" {
  default = "file"
}

variable "iam_role" {
  default = "defaultrole"
}

variable "iam_instance_profile" {
  default = "defaultprofile"
}

variable "tags" {
  default = "entry_load_server"
}