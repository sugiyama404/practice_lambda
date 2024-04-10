locals {
  opmng_sg_id_list = [
    { type = "ingress", port = "22" },
    { type = "egress", port = "80" },
    { type = "egress", port = "443" },
  ]
}

# SecurityGroupRules for dms
resource "aws_security_group_rule" "dms_out_tcp3306" {
  type              = "egress"
  from_port         = var.db_ports[0].internal
  to_port           = var.db_ports[0].external
  protocol          = var.db_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dms_sg.id
}

# SecurityGroupRules for opmng
resource "aws_security_group_rule" "opmng_web" {
  for_each = { for i in local.opmng_sg_id_list : i.port => i }

  type              = each.value.type
  from_port         = tonumber(each.value.port)
  to_port           = tonumber(each.value.port)
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.opmng_sg.id
}

resource "aws_security_group_rule" "opmng_out_db" {
  type              = "egress"
  from_port         = var.db_ports[0].internal
  to_port           = var.db_ports[0].external
  protocol          = var.db_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.opmng_sg.id
}

# SecurityGroupRules for source db
resource "aws_security_group_rule" "dbsource_in_tcp3306_from_opmng" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.opmng_sg.id
  security_group_id        = aws_security_group.rds_source_sg.id
}

resource "aws_security_group_rule" "dbsource_in_tcp3306_from_dms" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.dms_sg.id
  security_group_id        = aws_security_group.rds_source_sg.id
}

# SecurityGroupRules for target db
resource "aws_security_group_rule" "dbtarget_in_tcp3306_from_opmng" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.opmng_sg.id
  security_group_id        = aws_security_group.rds_target_sg.id
}

resource "aws_security_group_rule" "dbtarget_in_tcp3306_from_dms" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.dms_sg.id
  security_group_id        = aws_security_group.rds_target_sg.id
}
