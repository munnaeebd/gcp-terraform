module "module_1_firewal_rule" {
  source               = "./modules/firewall_rules"

  # Get count for firewall rules to create
  # count = length(var.firewall_rules)
  name = "${local.env}-${local.project}-module-1"

  network = module.vpc.network_name
  port = ["80", "8080"]
  source_ranges = ["0.0.0.0/0"]
  # Target tags
  target_tags = [local.module_1_tag]

  # Priority
  priority = 100

}
module "module_2_firewal_rule" {
  source               = "./modules/firewall_rules"

  # Get count for firewall rules to create
  # count = length(var.firewall_rules)
  name = "${local.env}-${local.project}-module-2"

  network = module.vpc.network_name
  port = ["80", "9090"]
  source_ranges = ["0.0.0.0/0"]
  # Target tags
  target_tags = [local.module_2_tag]

  # Priority
  priority = 100

}