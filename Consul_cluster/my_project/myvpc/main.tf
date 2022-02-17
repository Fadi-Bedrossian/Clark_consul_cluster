module "vpc" {
  source   = "/root/Consul_cluster/modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_ip_cidr
}
