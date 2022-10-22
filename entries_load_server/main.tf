terraform {
  required_version = ">= 0.12"
}

resource "aws_instance" "ec2" {
  count                       = var.private_subnet_count
  ami                         = var.ami
  instance_type               = "t1.micro"
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls_sg.id]
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name = "public_instance"
  }
}