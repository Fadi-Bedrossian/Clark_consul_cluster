resource "aws_security_group_rule" "ingress" {
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  security_group_id = module.ec2.security_group_id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
