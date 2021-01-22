variable "aws_regio" {
  description = "The AWS region for machine deploy."
  default = ""
}
variable "aws_server_name" {
  description = "The AWS virtual machines name for deploy."
  type = string
  default = ""
}
/*variable "aws_ami" {
  description = "The AWS AMI"
  default = ""
}
*/
variable "aws_instance" {
  description = "The AWS Instance type"
  default = ""
}
variable "aws_count" {
  description = "The number of AWS servers of this type"
  default = "1"
}
variable "aws_user_data" {
  description = "The user bootstrap script"
  default = ""
}
variable "aws_sec_group" {
  description = "The name of Security group"
  default = ""
}
variable "ingress_rule" {
  description = "mapping ingress replication"
  default = {
    "web_server" = ["80", "443", "22"]
  }
}
variable "egress_rule" {
  description = "mapping ingress replication"
  default = {
    "web_server" = ["0", "0"]
  }
}
variable "aws_server_environment" {
  description = "The name of enviroment server belong to"
  default = "STAGE"
}

variable "aws_main_tags" {
  description = "The AWS tags"
  type = map
  default = {
    Owner = "Maksym Levchenko"
    Project = "DevOps_practice"
   }
}

