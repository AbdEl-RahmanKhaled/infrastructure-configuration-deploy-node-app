resource "aws_db_instance" "rds" {
  db_subnet_group_name = aws_db_subnet_group.main-sub-g.name
  vpc_security_group_ids  = [aws_security_group.db-sg.id]
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "${var.ws_name}_db"
  username             = "admin"
  password             = "Admin2022"
#   parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}