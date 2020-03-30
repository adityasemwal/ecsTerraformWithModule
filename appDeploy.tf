# app

data "template_file" "myapp-task-definition-template" {
  template = file("templates/app.json.tpl")
  vars = {
    REPOSITORY_URL = "adityasemwal/javajmx"
  }
}

resource "aws_ecs_task_definition" "myapp-task-definition" {
  family                = "terraform-app"
  container_definitions = data.template_file.myapp-task-definition-template.rendered
}

resource "aws_elb" "myapp-elb" {
  name = "terraform-myapp-elb"

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    target              = "HTTP:3000/"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = [module.vpc.subnet_id_1, module.vpc.subnet_id_2]
  security_groups = [aws_security_group.myapp-elb-securitygroup.id]

  tags = {
    Name = "terraform-myapp-elb"
  }
}

resource "aws_ecs_service" "myapp-service" {
  name            = "terraform-myapp"
  cluster         = aws_ecs_cluster.example-cluster.id
  task_definition = aws_ecs_task_definition.myapp-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach1]

  load_balancer {
    elb_name       = aws_elb.myapp-elb.name
    container_name = "terraform-myapp"
    container_port = 8080
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}
