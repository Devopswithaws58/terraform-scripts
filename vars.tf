variable "ami" {
  default = "ami-03f4878755434977f"
  description = "Amazon image id"
}
variable "instances_count" {
  default = "2"
  description = "Total no. of instances are required"
}
variable "instance_type" {
  default = "t2.micro"
  description = "type of instance value"
}
variable "key_name" {
  default = "devopsawsnewkey"
  description = "key value is required to connect to instnce"
}
variable "security_groups" {
  description = "security group id requires to allow inbound rules"
  default = "default"
}
variable "cidr" {
  default = "10.0.0.0/16" 
}