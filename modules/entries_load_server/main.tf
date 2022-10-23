terraform {
  required_version = ">= 0.12"
}

resource "aws_instance" "entry_ingestion" {
  count                       = var.ec2_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.public_access
  key_name                    = var.keypair
  vpc_security_group_ids      = var.vpc_security_group_ids
  user_data                   = var.user_data
  iam_instance_profile        = var.iam_instance_profile

  tags = {
    Name = var.tags
  }
}