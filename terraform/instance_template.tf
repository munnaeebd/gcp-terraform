module "module_1_instance_template" {
  source               = "./modules/instance_template"
  name                 = "${local.env}-${local.project}-module-1-"
  project_id           = local.project_id
  machine_type         = local.instance_type
  common_name          = "${local.env}-${local.project}"

  labels               = {
    munna-labels  = "test"
    munna-labels-2 = "test2"
  }
  tags                 = ["module-1",
                         "firewall-iap" 
                         ]
  # source_image         = "ubuntu-os-cloud/ubuntu-2204-lts"
  source_image         = module.module-1-image.image_id
  disk_size_gb         = "50"
  disk_type            = "pd-ssd"
  service_account_email = google_service_account.module_1.email
  network              = module.vpc.network
  subnetwork           = lookup(module.vpc.subnets, "PRIVATE", "none")
  # access_config        = local.access_config
  preemptible          = false
}

module "module_2_instance_template" {
  source               = "./modules/instance_template"
  name                 = "${local.env}-${local.project}-module-2-"
  project_id           = local.project_id
  machine_type         = local.instance_type
  common_name          = "${local.env}-${local.project}"

  labels               = {
    app = "module-2"
  }
  tags                 = ["module-2",
                         "firewall-iap" 
                         ]
  source_image         = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size_gb         = "50"
  disk_type            = "pd-ssd"
  service_account_email = google_service_account.module_2.email
  network              = module.vpc.network
  subnetwork           = lookup(module.vpc.subnets, "PRIVATE", "none")
  # access_config        = local.access_config
  preemptible          = false
}