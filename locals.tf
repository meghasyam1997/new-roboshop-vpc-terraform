locals {
  tags = {
    business_unit = "ecommerce"
    business_type = "retail"
    project       = "roboshop"
    cost_center   = 100
    env           = var.env
  }

  vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
}