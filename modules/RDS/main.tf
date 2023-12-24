resource "aws_db_instance" "RDS" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  db_name              = "devopsaws"
  username             = "admin"
  password             = "devopsaws786"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}