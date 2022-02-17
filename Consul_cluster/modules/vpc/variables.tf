variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Base CIDR block which is divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}

variable "vpc_name" {
  type        = string
  default     = null
  description = "name of the VPC to create"
}

variable "rsc_count" {
  type    = number
  default = 3
}
