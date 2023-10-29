module "module_1_backend_service" {
  source = "./modules/load_balancer_backend"

  # Inputs
#   backend_name         = var.backend_name
#   backend_portname     = var.backend_portname
#   backend_protocol     = var.backend_protocol
  backend_name     = "${local.env}-${local.project}-module-1"
  backend_portname = "http-8080"
  backend_protocol = "HTTP"
  project_id      = local.project_id
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend_healthchecks = module.module_1_manage_instance_groups.http_health_check
  instance_group_mgr  = module.module_1_manage_instance_groups.instance_group
  backends = [
    { balance_mode = "UTILIZATION", capacity_scaler = 1, max_rate_per_instance = 0, max_utilization = 0.8 }
  ]
}

module "module_2_backend_service" {
  source = "./modules/load_balancer_backend"

  # Inputs
#   backend_name         = var.backend_name
#   backend_portname     = var.backend_portname
#   backend_protocol     = var.backend_protocol
  backend_name     = "${local.env}-${local.project}-module-2"
  backend_portname = "http-8080"
  backend_protocol = "HTTP"
  project_id      = local.project_id
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend_healthchecks = module.module_2_manage_instance_groups.http_health_check
  instance_group_mgr  = module.module_2_manage_instance_groups.instance_group
  backends = [
    { balance_mode = "UTILIZATION", capacity_scaler = 1, max_rate_per_instance = 0, max_utilization = 0.8 }
  ]
}