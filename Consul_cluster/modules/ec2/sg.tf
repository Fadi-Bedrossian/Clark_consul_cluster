resource "aws_security_group" "this" {
  name   = "${var.ec2_name}-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "egress" {
  from_port         = 0
  to_port           = 0
  type              = "egress"
  security_group_id = aws_security_group.this.id
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
