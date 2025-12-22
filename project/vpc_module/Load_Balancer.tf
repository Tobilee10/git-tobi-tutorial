resource "aws_lb_target_group" "WebTG" {
  name     = "WebTG"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.custom_vpc.id
  
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "WebTG"
  }
}

resource "aws_lb" "WebALB" {
  name               = "WebALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_ALBSG.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  enable_deletion_protection = false
  
  tags = {
    Environment = "WebALB"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.WebALB.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebTG.arn
  }
}
  
