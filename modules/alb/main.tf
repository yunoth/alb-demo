resource "aws_lb" "this" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = "application"
  security_groups            = [var.security_groups]
  subnets                    = var.subnets
  enable_deletion_protection = false
  tags                       = var.tags
}


resource "aws_lb_target_group" "app" {
  name     = "demo-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "test" {
  count            = length(var.instance_id)
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.instance_id[count.index]
  port             = 80
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}


##########################################################

output "alb_cname" {
  value = aws_lb.this.dns_name
}