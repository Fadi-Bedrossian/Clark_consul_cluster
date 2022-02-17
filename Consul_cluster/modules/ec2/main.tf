data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

resource "aws_instance" "ec2_instance" {
  count = var.ec2_count

  ami                    = data.aws_ami.amazon_linux.image_id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.this.id]
  subnet_id              = var.subnet_id[count.index]
  key_name               = var.key_name
  user_data              = var.user_data

  tags = {
    Name = "consul-ec2-${var.ec2_name}-${count.index}"
  }
}
