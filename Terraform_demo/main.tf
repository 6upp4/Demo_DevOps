module "aws_cloud" {
  source = "./aws_cloud"

  aws_regio       = "eu-central-1"
  aws_instance    = "t2.micro"
  aws_server_name = "Ubuntu_test"
  #aws_server_environment - PROD, STAGE(default), TEST used in Tags
  aws_server_environment = "STAGE"
  #aws_sec_group - defauft template for allow ports in security group, edit in vars.tf
  aws_sec_group = "web_server"
  aws_user_data = "./external_scripts/test.sh"
  # aws_count                  = "" /*If needed more same servers, default 1*/
  #  aws_ami                    = latest Amazon linux
}

module "openvpn" {
  source = "./openvpn"

  server_region = "eu-central-1"
}



#for make available outputs from the module AWS
output "main_AWS_outputs" {
  value = module.aws_cloud
}

#for make available outputs from the module OpenVPNPN
output "main_OpenVPN_outputs" {
  value = module.openvpn
}
