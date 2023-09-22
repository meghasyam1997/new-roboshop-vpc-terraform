module "vpc" {
  source = "git::https://github.com/meghasyam1997/new-vpc-terraform.git"

  for_each         = var.vpc
  cidr_block       = each.value["cidr_block"]
  subnets          = each.value["subnets"]
  default_vpc_id   = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_rtid = var.default_vpc_rtid
  tags             = local.tags
  env              = var.env
}


module "apps" {
  source = "git::https://github.com/meghasyam1997/new-tf-module-app.git"

  for_each         = var.apps
  name             = each.value["component_name"]
  instance_type    = each.value["instance_type"]
  desired_capacity = each.value["desired_capacity"]
  max_size         = each.value["max_size"]
  min_size         = each.value["min_size"]

  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_app_cidr"], null), "subnet_cidrs", null)

  env          = var.env
  bastion_cidr = var.bastion_cidr
  tags         = local.tags
}

module "docdb" {
  source = "git::https://github.com/meghasyam1997/new-tf-module-docdb.git"

  for_each       = var.docdb
  engine_version = each.value["engine_version"]
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]

  subnets       = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnet_cidrs", null)

  env     = var.env
  tags    = local.tags
  kms_arn = var.kms_arn
  vpc_id  = local.vpc_id
}

module "rds" {
  source = "git::https://github.com/meghasyam1997/new-tf-module-rds.git"

  for_each       = var.rds
  engine_version = each.value["engine_version"]
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]

  subnets       = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnet_cidrs", null)

  env     = var.env
  vpc_id  = local.vpc_id
  tags    = local.tags
  kms_arn = var.kms_arn
}

module "elasticache" {
  source = "git::https://github.com/meghasyam1997/new-tf-module-elasticache.git"

  for_each                = var.elasticache
  engine_version          = each.value["engine_version"]
  replicas_per_node_group = each.value["replicas_per_node_group"]
  num_node_groups         = each.value["num_node_groups"]
  node_type               = each.value["node_type"]

  subnets       = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnet_cidrs", null)

  env     = var.env
  vpc_id  = local.vpc_id
  tags    = local.tags
  kms_arn = var.kms_arn
}

module "rabbitmq" {
  source = "git::https://github.com/meghasyam1997/new-tf-module-amazon-mq.git"

  for_each      = var.rabbitmq
  instance_type = each.value["instance_type"]

  subnets       = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnets_ids", null)
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["allow_db_cidr"], null), "subnet_cidrs", null)

  env          = var.env
  tags         = local.tags
  bastion_cidr = var.bastion_cidr
  vpc_id       = local.vpc_id
  kms_arn      = var.kms_arn
}