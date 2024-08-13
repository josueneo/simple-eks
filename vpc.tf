locals {
  create_vpc = var.vpc_id == null ? true : false
}
locals {
  vpc = (
    local.create_vpc ? {
      id = module.vpc[0].vpc_id
      } : {
      id = data.aws_vpc.selected[0].id
    }
  )
}

data "aws_vpc" "selected" {
  count = local.create_vpc ? 0 : 1
  id    = var.vpc_id
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>5.0"

  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.vpc_azs
  enable_nat_gateway = true
  single_nat_gateway = true

  private_subnets = var.subnet_private
  create_vpc = var.vpc_id == null ? true : false
}

resource "aws_security_group" "allow_all" {
  name        = "enterprise-demo-all"
  description = "Allow all inbound traffic and all outbound traffic"
  vpc_id      = local.vpc.id
  count       = local.create_vpc ? 1 : 0

}
resource "aws_vpc_security_group_ingress_rule" "allow_all_tcp_ing" {
  security_group_id = aws_security_group.allow_all[0].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  count             = local.create_vpc ? 1 : 0
}
resource "aws_vpc_security_group_egress_rule" "allow_all_tcp_egg" {
  security_group_id = aws_security_group.allow_all[0].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  count             = local.create_vpc ? 1 : 0
}