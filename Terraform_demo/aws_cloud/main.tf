provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_regio
}

resource "aws_instance" "temp_server_name" {
  ami = data.aws_ami.fresh_amazom_linux.id
  instance_type = var.aws_instance
  count = var.aws_count
  vpc_security_group_ids = [aws_security_group.temp_sec_group.id]

  user_data = "${var.aws_user_data}"


  tags = merge(var.aws_main_tags, {Environment = var.aws_server_environment}, {Name = var.aws_server_name})
}

resource "aws_eip" "server_ip" {
  instance  = aws_instance.temp_server_name[0].id
  tags = merge(var.aws_main_tags, {Environment = var.aws_server_environment}, {Name = var.aws_server_name})
}

resource "aws_security_group" "temp_sec_group" {
  name = "Security grop for ${var.aws_sec_group}"
  description = "Security grop for ${var.aws_sec_group}"
  tags = merge(var.aws_main_tags, {Environment = var.aws_server_environment}, {Name = var.aws_server_name})

  dynamic "ingress" {
    for_each = "${lookup(var.ingress_rule, var.aws_sec_group)}"
    content{
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
    dynamic "egress" {
    for_each = "${lookup(var.egress_rule, var.aws_sec_group)}"
    content{
      from_port = egress.value
      to_port = egress.value
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      }
    }
}
