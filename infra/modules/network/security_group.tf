# SecurityGroup for DMS
resource "aws_security_group" "dms_sg" {
  name   = "dms-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-dms-sg"
  }
}

# SecurityGroup for opmng
resource "aws_security_group" "opmng_sg" {
  name   = "opmng-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-opmng-sg"
  }
}

# SecurityGroup for RDS
resource "aws_security_group" "rds_source_sg" {
  name   = "rds-source-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-rds-source-sg"
  }
}

resource "aws_security_group" "rds_target_sg" {
  name   = "rds-target-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-rds-target-sg"
  }
}
