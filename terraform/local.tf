locals {  
  env         = terraform.workspace
  owner       = "SAP"
  cost-center = "internal"
  project     = "rnd"
  version     = "v0.0.1"
  project_id  = "munna-rnd"
  region      = "asia-southeast1"
  common_tags = {
    Environment = local.env
    Version     = local.version
    Owner       = local.owner
    Cost-Center = local.cost-center
    Project     = local.project
  }

  vpc_cidr_blocks = {
    uat  = "10.10.192.0/20"
    sb   = ""
    lt   = ""
    prod = "10.10.176.0/20"
  }
  vpc-cidr-block = lookup(local.vpc_cidr_blocks, local.env, null)

#   subnets = {
#     prod  = {}
#     sb   = {}
#     lt   = {}
#     uat = {
#       "10.10.192.0/24" = {
#         subnet-name = join("-", [local.env, local.project, "subnet-1"])
#         subnet_region = local.region
#       }
#     }
#   }

  # subnets = {
  #   prod = []
  #   uat = [
  #       {
  #           subnet_name           = join("-", [local.env, local.project, "subnet-1"])
  #           subnet_ip             = "10.10.192.0/24"
  #           subnet_region         = local.region
  #           subnet_private_access = "true"
  #           description           = "${local.env}-${local.project}-Subnet" 

  #       }
  #   ]
  # }
  # subnet = lookup(local.subnets, local.env, null)

  tf_subnet = {
    uat  = "10.10.192.0/24"
    lt   = "10.10.193.0/24"
    prod = "10.10.194.0/24"
  }
  subnet = local.tf_subnet[local.env]
 
  tf_network_mtu = {
    uat  = "1500"
    prod = ""
  }
  network_mtu = local.tf_network_mtu[local.env]
  tf_autoscaling_enabled = {
    uat  = "1500"
    prod = ""
  }
  autoscaling_enabled = local.tf_autoscaling_enabled[local.env]
  tf_instance_types = {
    uat  = "e2-micro"
    lt   = "e2-medium"
    prod = "e2-medium"
  }
  instance_type = local.tf_instance_types[local.env]
  tf_domain_name = {
    uat  = "munnasite.com"
    lt   = "munnasite.com"
    prod = "munnasite.com"
  }
  domain_name = local.tf_domain_name[local.env]
  tf_module_1_tag = {
    uat  = "module-1"
    lt   = "module-1"
    prod = "module-1"
  }
  module_1_tag = local.tf_module_1_tag[local.env]
  tf_module_2_tag = {
    uat  = "module-2"
    lt   = "module-2"
    prod = "module-2"
  }
  module_2_tag = local.tf_module_2_tag[local.env]
  tf_module_1_min_replicas = {
    uat  = "0"
    prod = ""
  }
  module_1_min_replicas = local.tf_module_1_min_replicas[local.env]

  tf_module_1_max_replicas = {
    uat  = "3"
    prod = ""
  }
  module_1_max_replicas = local.tf_module_1_max_replicas[local.env]  
  tf_module_2_min_replicas = {
    uat  = "0"
    prod = ""
  }
  module_2_min_replicas = local.tf_module_2_min_replicas[local.env]

  tf_module_2_max_replicas = {
    uat  = "3"
    prod = ""
  }
  module_2_max_replicas = local.tf_module_2_max_replicas[local.env] 

}  
