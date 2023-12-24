variable "ami" {
  description = "Amazon image id"
}
/*
variable "instances_count" {
  default     = "2"
  description = "Total no. of instances are required"
}
*/
variable "instance_type" {
  description = "type of instance value"
}
variable "key_name" {
  description = "key value is required to connect to instnce"
}
/* 
variable "security_groups" {
  description = "security group id requires to allow inbound rules"
  default     = "default"
}
*/
variable "cidr" {
  description = "cidr port range value for VPC"
}
