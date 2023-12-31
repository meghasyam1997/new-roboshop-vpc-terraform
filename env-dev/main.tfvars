env = "dev"
bastion_cidr = ["172.31.94.36/32"]
default_vpc_id = "vpc-02fd95dec0b93d08a"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-04788961f7eb75f09"
kms_arn = "arn:aws:kms:us-east-1:844746520101:key/f2e4231a-4405-4fcc-9d18-bb7c5e81348f"

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      public = {
        name = "public"
        cidr_block = ["10.0.0.0/24","10.0.1.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
      web = {
        name = "web"
        cidr_block = ["10.0.2.0/24","10.0.3.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
      app = {
        name = "app"
        cidr_block = ["10.0.4.0/24","10.0.5.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
      db = {
        name = "db"
        cidr_block = ["10.0.6.0/24","10.0.7.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
    }
  }
}

apps = {
  frontend = {
    component_name = "frontend"
    instance_type = "t3.small"
    subnet_name = "web"
    allow_app_cidr = "public"
    desired_capacity = 2
    max_size = 10
    min_size = 2
  }
  catalogue = {
    component_name = "catalogue"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
    desired_capacity = 2
    max_size = 10
    min_size = 2
  }
  cart = {
    component_name = "cart"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
    desired_capacity = 2
    max_size = 10
    min_size = 2
  }
  shipping = {
    component_name = "shipping"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
    desired_capacity = 2
    max_size = 10
    min_size = 2
  }
  payment = {
    component_name = "payment"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
    desired_capacity = 2
    max_size = 10
    min_size = 2
  }
  user = {
    component_name = "user"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
    desired_capacity = 2
    max_size = 10
    min_size = 2
  }
}

docdb = {
  main = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "4.0.0"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}

rds = {
  main = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "5.7.mysql_aurora.2.11.2"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}

elasticache = {
  main = {
    subnet_name             = "db"
    allow_db_cidr           = "app"
    engine_version          = "6.x"
    replicas_per_node_group = 1
    num_node_groups         = 1
    node_type               = "cache.t3.micro"
  }
}

rabbitmq = {
  main = {
    subnet_name   = "db"
    allow_db_cidr = "app"
    instance_type = "t3.small"
  }
}