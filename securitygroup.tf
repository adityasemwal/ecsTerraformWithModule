resource "aws_security_group" "ecs-securitygroup" {
  vpc_id      = module.vpc.vpc_id
  name        = "terraform-ecs"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  dynamic "ingress"{
    for_each = var.ports
    content{
      from_port = ingress.key
      to_port = ingress.key
      protocol = "tcp"
      cidr_blocks = ingress.value
    }
  }

  tags = {
    Name = "terraform-ecs"
  }
}

resource "aws_security_group" "myapp-elb-securitygroup" {
  vpc_id      = module.vpc.vpc_id
  name        = "terraform-myapp-elb"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-myapp-elb"
  }
}
