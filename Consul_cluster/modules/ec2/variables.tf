variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_count" {
  type    = number
  default = "3"
}

variable "ec2_name" {
  type    = string
  default = null
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = list(string)
  default = null
}
variable "key_name" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}
