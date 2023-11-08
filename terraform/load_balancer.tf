module "load_balancer" {
  source = "./modules/load_balancer"
  project_id      = local.project_id
  name    = "${local.env}-${local.project}"
  hosts = [local.domain_name]

  # Forwarding Role
  forwarding_rules = [
  { forwardingrule_name = "${local.env}-${local.project}-http-frontend", forwardingrule_protocol = "TCP", ip_version = "IPV4"
  load_balancing_scheme = "EXTERNAL_MANAGED", port_range = "80" }
  ]
  network              = module.vpc.network
  subnetwork           = lookup(module.vpc.subnets, "PRIVATE", "none")

  default_backend = module.module_1_backend_service.backend_id
  path_rule = [
    { paths   = ["/home"], service = module.module_1_backend_service.backend_id },
    { paths   = ["/login"], service = module.module_1_backend_service.backend_id },
    { paths   = ["/module2"], service = module.module_2_backend_service.backend_id }
  ]
}