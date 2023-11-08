module "module_1_manage_instance_groups" {
  source              = "./modules/manage_instance_groups"
  region              = local.region
  project_id          = local.project_id
  instance_name       = "${local.env}-${local.project}-module-1"
  min_replicas        = local.module_1_min_replicas
  max_replicas        = local.module_1_max_replicas
  instance_template   = module.module_1_instance_template.self_link
  autoscaling_enabled = true
  common_name         = "${local.env}-${local.project}"
  scaling_schedules = [{
    disabled              = false
    name                  = "every-weekday-morning"
    description           = "Increase to 2 every weekday at 7AM for 12 hours."
    min_required_replicas = 2
    schedule              = "25 13 * * *"
    time_zone             = "Asia/Dhaka"
    duration_sec          = 300
  },
  {
    disabled              = false
    name                  = "every-evening-test"
    description           = "Increase to 2 every weekday."
    min_required_replicas = 2
    schedule              = "30 13 * * *"
    time_zone             = "Asia/Dhaka"
    duration_sec          = 300
  }]
  named_ports  = [{
    name = "http-8080"
    port = 80
  }]
  health_check = {
    type                = "http"
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
    enable_logging      = false
  }
}

module "module_2_manage_instance_groups" {
  source              = "./modules/manage_instance_groups"
  region              = local.region
  project_id          = local.project_id
  instance_name       = "${local.env}-${local.project}-module-2"
  min_replicas        = local.module_2_min_replicas
  max_replicas        = local.module_2_max_replicas
  instance_template   = module.module_2_instance_template.self_link
  autoscaling_enabled = true
  common_name         = "${local.env}-${local.project}"
  scaling_schedules = [{
    disabled              = false
    name                  = "every-weekday-morning"
    description           = "Increase to 2 every weekday at 7AM for 12 hours."
    min_required_replicas = 2
    schedule              = "25 13 * * *"
    time_zone             = "Asia/Dhaka"
    duration_sec          = 300
  }]
  named_ports  = [{
    name = "http-8080"
    port = 80
  }]
  health_check = {
    type                = "http"
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
    enable_logging      = false
  }
}



