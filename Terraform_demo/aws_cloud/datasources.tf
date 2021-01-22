data "aws_availability_zones" "availabile" {}

data "aws_region" "current1" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "fresh_amazom_linux" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}