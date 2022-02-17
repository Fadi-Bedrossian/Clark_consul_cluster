resource "aws_key_pair" "login_key" {
  key_name   = "ssh-bastion"
  public_key = file("${path.module}/files/key.pub")
}
