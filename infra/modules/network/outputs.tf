output "db_sbg_name" {
  value = aws_db_subnet_group.db-sg.name
}

output "sg_rds_source_id" {
  value = aws_security_group.rds_source_sg.id
}

output "sg_lambda_id" {
  value = aws_security_group.lambda_sg.id
}

output "subnet_private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}

output "subnet_private_subnet_1c_id" {
  value = aws_subnet.private_subnet_1c.id
}
