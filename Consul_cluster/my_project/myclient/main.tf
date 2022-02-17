module "ec2" {
  source    = "../../modules/ec2"
  ec2_name  = var.ec2_name
  vpc_id    = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets
  user_data = file("${path.module}/template/install_client_pkgs.tpl")
}
