resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instancetype
  associate_public_ip_address = var.publicip
  iam_instance_profile = var.profile
  key_name = aws_key_pair.tfkey.key_name
  vpc_security_group_ids = var.sg

  tags = {
    Name = "${var.allname}-instance"
  }
}

resource "aws_key_pair" "tfkey" {
  key_name   = "tfkey"
  public_key = tls_private_key.rsakey.public_key_openssh
  }

  resource "tls_private_key" "rsakey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}