provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA3LPVUFCQKMGDDZRA"
    secret_key = "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"
}
resource "aws_instance" "WEBServer1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.webSG.id]
  subnet_id              = aws_subnet.sub1.id
  //security_groups = [ "${var.security_groups}" ]
  tags = {
    Name = "webserver-1"
  }
  user_data = base64encode(file("installApache2.sh"))
}
resource "aws_instance" "WEBServer2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.webSG.id]
  subnet_id              = aws_subnet.sub2.id
  //security_groups = [ "${var.security_groups}" ]
  tags = {
    Name = "webserver-2"
  }
  user_data = base64encode(file("installApache2.sh"))
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "s3bucket-99"
  tags = {
    Name = "s3bucket-99"
  }
}
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
resource "aws_vpc" "DEVOPS-AWS-PROJECT" {
  cidr_block = var.cidr
}
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.DEVOPS-AWS-PROJECT.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.DEVOPS-AWS-PROJECT.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.DEVOPS-AWS-PROJECT.id
}
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.DEVOPS-AWS-PROJECT.id
}
resource "aws_route" "route" {
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.RT.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.RT.id
}
resource "aws_security_group" "webSG" {
  name   = "web"
  vpc_id = aws_vpc.DEVOPS-AWS-PROJECT.id

  ingress {
    description = "allow all traffic from VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_alb" "devopsawsALB" {
  name               = "devopsawsALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webSG.id]
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]
  tags = {
    Name = "web"
  }
}
resource "aws_lb_target_group" "TG" {
  name     = "devopsawsTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.DEVOPS-AWS-PROJECT.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}
resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.WEBServer1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.WEBServer2.id
  port             = 80
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.devopsawsALB.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.TG.arn
    type             = "forward"
  }
}

