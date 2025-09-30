resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-dbsubnet"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "${var.project_name}-dbsubnet"
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${var.project_name}-pg"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.9" # version soportada y estable.Postgres9 es EOL.
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = {
    Name = "${var.project_name}-postgres"
  }
}

