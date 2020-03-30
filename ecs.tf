# cluster
resource "aws_ecs_cluster" "example-cluster" {
  name = "Terraform-Aditya"
}

resource "aws_launch_configuration" "ecs-example-launchconfig" {
  name_prefix          = "ecs-terraform"
  image_id             = data.aws_ami.amazonEcs.id
/*  image_id             = "ami-0fddd00791ff99163"*/
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.mykeypair.key_name
  iam_instance_profile = aws_iam_instance_profile.ecs-ec2-role.id 
  security_groups      = [aws_security_group.ecs-securitygroup.id]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=Terraform-Aditya' > /etc/ecs/ecs.config\ndocker run  --volume=/:/rootfs:ro  --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8085:8080 --detach=true --name=cadvisor --privileged=true --volume=/cgroup:/cgroup:ro  google/cadvisor:v0.24.1"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs-example-autoscaling" {
  name_prefix                 = "ecs-terraform-autoscaling"
  vpc_zone_identifier  = [module.vpc.subnet_id_1, module.vpc.subnet_id_2]
  launch_configuration = aws_launch_configuration.ecs-example-launchconfig.name
  min_size             = 1
  max_size             = 1
  tag {
    key                 = "Name"
    value               = "ecs-ec2-container-terraform"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
