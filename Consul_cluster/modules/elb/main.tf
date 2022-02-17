
resource "aws_elb" "consul_elb" {
  name                        = "Consul-elb"
  instances                   = var.instances_id
  subnets                     = var.public_subnets
  security_groups             = [aws_security_group.elb_sg.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 300
  internal                    = false


  listener {
    instance_port     = 8500
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  /*listener {
    instance_port      = 8500
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }*/

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:8500/v1/status/leader"
    interval            = 30
  }


  tags = {
    Name = "consul-server-elb"
  }
}
