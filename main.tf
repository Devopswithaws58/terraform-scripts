module "ec2_instance" {
  source        = "./modules/ec2-instance"
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"
  key_name      = "devopsawsnewkey"
}
module "VPC" {
  source = "./modules/VPC"
  cidr   = "10.0.0.0/16"
}
module "RDS" {
  source = "./modules/RDS"
}
module "aws_s3_bucket" {
  source = "./modules/s3-buckets"
}
