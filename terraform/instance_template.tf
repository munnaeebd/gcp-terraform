module "module_1_instance_template" {
  source               = "./modules/instance_template"
  name                 = "${local.env}-${local.project}-module-1-instance-template"
  project_id           = local.project_id
  machine_type         = local.instance_type
  common_name          = "${local.env}-${local.project}"

  labels               = {
    munna-labels  = "test"
    munna-labels-2 = "test2"
  }
  tags                 = [local.module_1_tag]
  source_image         = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size_gb         = "50"
  disk_type            = "pd-ssd"
  service_account_email = google_service_account.module_1.email
  network              = module.vpc.network
  subnetwork           = module.vpc.subnets
  # access_config        = local.access_config
  preemptible          = false
}

module "module_2_instance_template" {
  source               = "./modules/instance_template"
  name                 = "${local.env}-${local.project}-module-2-instance-template"
  project_id           = local.project_id
  machine_type         = local.instance_type
  common_name          = "${local.env}-${local.project}"

  labels               = {
    app = "module-2"
  }
  tags                 = [local.module_2_tag]
  source_image         = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size_gb         = "50"
  disk_type            = "pd-ssd"
  service_account_email = google_service_account.module_2.email
  network              = module.vpc.network
  subnetwork           = module.vpc.subnets
  # access_config        = local.access_config
  preemptible          = false
}