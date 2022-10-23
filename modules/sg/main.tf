terraform {
  required_version = ">= 0.12"
}

#Security groups
resource "aws_security_group" "allow_tls_sg" {
  name        = "allow_tls-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #We will save restricted ips of organization's vpn instead 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "allow_tls"
  }
}


#Security groups that allows access to db
resource "aws_security_group" "cms_pg_sg" {
  name        = "postgres-sg"
  description = "Allow pg-db inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow to talk to postgres"
    from_port   = 5342
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #We will save restricted ips of organization's vpn 
    # instead if db in public subnet 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "postgres"
  }
}