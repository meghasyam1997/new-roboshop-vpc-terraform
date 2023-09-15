module "vpc" {
  for_each   = var.vpc
  source     = "git::https://github.com/meghasyam1997/new-vpc-terraform.git"
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags       = local.tags
  env        = var.env
}