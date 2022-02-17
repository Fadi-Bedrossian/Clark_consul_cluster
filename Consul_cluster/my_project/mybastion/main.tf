module "ec2" {

  source    = "../../modules/ec2"
  ec2_name  = var.ec2_name
  ec2_count = var.ec2_count
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnets
  key_name  = aws_key_pair.login_key.key_name
  vpc_id    = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_eip" "bastion_eip" {
  instance = module.ec2.ec2_instance_id[0]
  vpc      = true
}
