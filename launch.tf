/*module "instances" {
  source = "github.com/adityasemwal/tfmodule.git/instance"
  COUNT  = true
  subnet_id_1 = module.vpc.subnet_id_1
  vpc_id = module.vpc.vpc_id
  amiFrom = true
  AMI = data.aws_ami.amazonEcs.id
}*/

/*module "instances-us-west" {
  source   = "github.com/adityasemwal/tfmodule.git/instance"
  COUNT    = false
  subnet_id_1 = module.vpc.subnet_id_1
  vpc_id = module.vpc.vpc_id
  providers = {
    aws = aws.new_region
  }
}*/

module "vpc"{
  source = "github.com/adityasemwal/tfmodule.git/vpc"
}

