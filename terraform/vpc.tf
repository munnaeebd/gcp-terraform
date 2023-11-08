# module "vpc" {
#   source                                    = "./modules/vpc"
#   network_name                              = "${local.env}-${local.project}-network"
#   project_id                                = local.project_id
#   subnets                                   = local.subnet
#   mtu                                       = local.network_mtu
#   description                               = "${local.env}-${local.project}-network"
#   common_name                               = "${local.env}-${local.project}"
#   # enable_ipv6_ula                           = local.enable_ipv6_ula
#   # internal_ipv6_range                       = local.internal_ipv6_range
#   # shared_vpc_host                           = local.shared_vpc_host  
# }

module "vpc" {
    source  = "./modules/vpc"

    project_id   = local.project_id
    network_name = "${local.env}-${local.project}-network"
    common_name  = "${local.env}-${local.project}"
    service_subnet_name = "${local.env}-${local.project}-service-subnet"
    service_subnet  = local.service_subnet
    iap_rule_target_tag = ["firewall-iap"]

    subnets = [
        {
            subnet_name           = "${local.env}-${local.project}-subnet"
            subnet_ip             = local.subnet
            subnet_region         = local.region
            subnet_private_access = "true"
        },
        {
            subnet_name           = "${local.env}-${local.project}-proxy-subnet"
            subnet_ip             = local.proxy_subnet
            subnet_region         = local.region
            subnet_flow_logs      = "false"
            description           = "For regional Envoy-based load balancers"
            purpose               = "REGIONAL_MANAGED_PROXY"
            role                  = "ACTIVE"
        }
        # {
        #     subnet_name                  = "${local.env}-${local.project}-service-subnet"
        #     subnet_ip                    = local.service_subnet
        #     subnet_region                = local.region
        #     subnet_private_access = "true"
        #     # subnet_flow_logs             = "true"
        #     # subnet_flow_logs_interval    = "INTERVAL_10_MIN"
        #     # subnet_flow_logs_sampling    = 0.7
        #     # subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
        #     purpose                      = "PRIVATE_SERVICE_CONNECT"
        #     description                  = "For Private Service Connect"
        #     # subnet_flow_logs_filter_expr = "true"
        # }
    ]
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


