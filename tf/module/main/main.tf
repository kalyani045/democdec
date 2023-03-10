module "vpc" {
  source = "../vpc"
  subnetid = var.subnetid
  privatesubnet = var.privatesubnet
 vpccidr= var.vpccidr
  allname = var.allname
}

module "sg" {
  source    = "../sg"
  env       = var.env
  namespace = var.namespace
  vpc_id    = module.vpc.vpc_id
  ingress   = var.ingress
  tags      = var.tags
}

module "ec2" {
source    = "../ec2"
  ami = var.ami
  instancetype = var.instancetype
  publicip= var.publicip
  profile= var.profile
  sg = module.sg.security_group_id
  allname = var.allname
}