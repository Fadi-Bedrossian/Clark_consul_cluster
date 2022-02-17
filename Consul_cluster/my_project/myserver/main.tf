module "ec2" {
  source    = "../../modules/ec2"
  ec2_name  = var.ec2_name
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_id    = data.terraform_remote_state.vpc.outputs.vpc_id
  user_data = file("${path.module}/template/install_server_pkgs.tpl")
}
