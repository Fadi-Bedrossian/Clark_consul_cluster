resource "aws_security_group_rule" "ssh-bastion" {

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.ec2.security_group_id
  source_security_group_id = data.terraform_remote_state.bastion.outputs.security_group_id

}

resource "aws_security_group_rule" "ingress" {

  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
  security_group_id = module.ec2.security_group_id

}
