module "elb" {

  source         = "../../modules/elb"
  instances_id   = module.ec2.ec2_instance_id
  public_subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id

}
