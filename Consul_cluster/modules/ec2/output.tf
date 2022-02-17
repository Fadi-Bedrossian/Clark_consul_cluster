output "security_group_id" {
  value = aws_security_group.this.id
}

output "ec2_instance_id" {
  value = aws_instance.ec2_instance.*.id
}

output "key_name" {
  value = aws_instance.ec2_instance.*.key_name
}
