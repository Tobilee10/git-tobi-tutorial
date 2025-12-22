data "aws_ami" "myami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "launch_template" {
  name = "web-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 10
    }
  }


  iam_instance_profile {
    name = aws_iam_instance_profile.LT_profile.name
  }

  image_id = aws_ami.myami.id

  instance_type = var.instance_type


  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.web_sg1.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Web-App-Tier"
    }
  }

  user_data = filebase64("${path.module}/script.sh")
}

resource "aws_autoscaling_group" "ASG"{
    vpc_zone_identifier  = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
    health_check_type = "ELB"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 1
    target_group_arns   = [aws_lb_target_group.WebTG.arn]

    launch_template {
     id      = aws_launch_template.launch_template.id
     version = "$Latest"
  }
}