module "vpc" {
  source                                    = "./modules/vpc"
  network_name                              = "${local.env}-${local.project}-network"
  project_id                                = local.project_id
  subnets                                   = local.subnet
  mtu                                       = local.network_mtu
  description                               = "${local.env}-${local.project}-network"
  common_name                               = "${local.env}-${local.project}"
  # enable_ipv6_ula                           = local.enable_ipv6_ula
  # internal_ipv6_range                       = local.internal_ipv6_range
  # shared_vpc_host                           = local.shared_vpc_host  
}

/******************************************
	Subnet configuration
 *****************************************/
# module "subnets" {
#   source           = "./modules/subnets"
#   project_id       = local.project_id
#   network_name     = module.vpc.network_name
#   subnets          = local.subnets
#   secondary_ranges = local.secondary_ranges
# }

/******************************************
	Routes
 *****************************************/
# module "routes" {
#   source            = "./modules/routes"
#   project_id        = local.project_id
#   network_name      = module.vpc.network_name
#   routes            = local.routes
#   module_depends_on = [module.subnets.subnets]
# }


