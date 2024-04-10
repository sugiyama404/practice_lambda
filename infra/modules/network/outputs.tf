output "db_sbg_name" {
  value = aws_db_subnet_group.db-sg.name
}

output "sg_rds_source_id" {
  value = aws_security_group.rds_source_sg.id
}

output "sg_rds_target_id" {
  value = aws_security_group.rds_target_sg.id
}

output "sg_opmng_id" {
  value = aws_security_group.opmng_sg.id
}

output "sg_dms_id" {
  value = aws_security_group.dms_sg.id
}

output "subnet_public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "subnet_public_subnet_1c_id" {
  value = aws_subnet.public_subnet_1c.id
}

output "subnet_private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}

output "subnet_private_subnet_1c_id" {
  value = aws_subnet.private_subnet_1c.id
}
