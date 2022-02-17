variable "vpc_id" {
  type    = string
  default = null
}

variable "public_subnets" {
  type    = list(string)
  default = null
}

variable "instances_id" {
  type    = list(string)
  default = null
}
