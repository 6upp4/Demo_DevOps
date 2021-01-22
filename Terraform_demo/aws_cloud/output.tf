output "DATA_aws_availability_zones" {
  value = data.aws_availability_zones.availabile.names
}

output "DATA_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "DATA_aws_Region_NAME" {
  value = data.aws_region.current1.name
}

output "DATA_aws_Region_DESCRIPTION" {
  value = data.aws_region.current1.description
}

output "Main_AWS_serwer_IP" {
  value = aws_eip.server_ip.public_ip
}

output "AWS_server_instanse_ID" {
  value = aws_instance.temp_server_name[0].id
}

output "AWS_security_Group_ID" {
  value = aws_security_group.temp_sec_group.id
}

