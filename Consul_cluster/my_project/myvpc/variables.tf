variable "region" {
  default = "us-east-1"
}
variable "vpc_ip_cidr" {
  type        = string
  description = "IP CIDR assigned to the environment"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "Consul_vpc"
}
