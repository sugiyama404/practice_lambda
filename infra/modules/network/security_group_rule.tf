# SecurityGroupRules for lambda
resource "aws_security_group_rule" "lambda_in_tcp3306" {
  type              = "egress"
  from_port         = var.db_ports[0].internal
  to_port           = var.db_ports[0].external
  protocol          = var.db_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lambda_sg.id
}

resource "aws_security_group_rule" "lambda_out_tcp" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lambda_sg.id
}

# SecurityGroupRules for source db
resource "aws_security_group_rule" "dbsource_in_tcp3306_from_opmng" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.lambda_sg.id
  security_group_id        = aws_security_group.rds_source_sg.id
}
