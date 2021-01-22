provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.server_region
}
resource "aws_instance" "openvpn" {
  ami                    = local.images[var.server_region]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              admin_user=${var.server_username}
              admin_pw=${var.server_password}
              EOF
  tags = {
    Name     = "openvpn"
    Developt = "6upp4.it"
  }
}
locals {
  images = {
    us-east-1      = "ami-037ff6453f0855c46"
    eu-central-1   = "ami-0764964fdfe99bc31"
    ap-northeast-1 = "ami-04f47c2ec43830d77"
  }
}
resource "aws_security_group" "instance" {
  name        = "openvpn-default"
  description = "OpenVPN security group"
  dynamic "ingress" {
    for_each = [22, 443, 943, 945, 1194]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = [0, 0]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
output "access_vpn_url" {
  value       = "https://${aws_instance.openvpn.public_ip}:943/admin"
  description = "The public url address of the vpn server"
}
variable "aws_access_key" {
  description = "Please provide aws_access_key:"
}
variable "aws_secret_key" {
  description = "Please provide aws_secret_key:"
}
variable "server_region" {
  description = <<EOT
                 Please provide a region for OpenVPN server:

                 us-east-1      = USA server  - N. Virginia,
                 eu-central-1   = EUROPE server - Frankfurt,
                 ap-northeast-1 = Asia - Tokyo,

                 or other!
EOT

  type = string
}
variable "server_username" {
  description = "Admin Username to access OpenVPN server"
  type        = string
}
variable "server_password" {
  description = "Admin Password to access OpenVPN server"
  type        = string
}
