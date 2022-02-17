data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../myvpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "bastion" {
  backend = "local"

  config = {
    path = "../mybastion/terraform.tfstate"
  }
}
