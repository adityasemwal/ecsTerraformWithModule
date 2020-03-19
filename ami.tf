data "aws_ami" "amazonEcs"{
  most_recent = true
  filter{
    name = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized*"]
  }
  filter{
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter{
    name = "root-device-type"
    values = ["ebs"]
  }
  owners = ["591542846629"]
}
