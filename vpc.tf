module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                = var.vpc_azs
  private_subnets    = var.subnet_private
  public_subnets     = var.subnet_public
  intra_subnets      = var.subnet_intra
  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "aws_security_group" "allow_all" {
  name        = "enterprise-demo-all"
  description = "Allow all inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id
}
resource "aws_vpc_security_group_ingress_rule" "allow_all_tcp_ing" {
  security_group_id = aws_security_group.allow_all.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}
resource "aws_vpc_security_group_egress_rule" "allow_all_tcp_egg" {
  security_group_id = aws_security_group.allow_all.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}