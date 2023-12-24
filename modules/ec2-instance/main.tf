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

