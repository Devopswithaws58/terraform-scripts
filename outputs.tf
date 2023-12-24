output "loadbalancerdns" {
  value = aws_alb.devopsawsALB.dns_name
}
output "WEBServer1-public_ip" {
  description = "Public IP address of the web server1 Instance"
  value       = aws_instance.WEBServer1.public_ip
}
output "WEBServer2-public_ip" {
  value       = aws_instance.WEBServer2.public_ip
  description = "Public IP address of the web server 2 instance"
}