data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "./modules/gke"
  project_id                 = local.project_id
  name                       = "${local.env}-${local.project}-cluster"
  region                     = local.region
  # zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = module.vpc.network
  subnetwork                 = lookup(module.vpc.subnets, "PRIVATE", "none")
  private_ipv4_cidr          = lookup(module.vpc.private_ipv4_cidr, "PRIVATE", "none")
  # ip_range_pods              = "us-central1-01-gke-01-pods"
  # ip_range_services          = "us-central1-01-gke-01-services"
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  # enable_private_endpoint    = true
  # enable_private_nodes       = true
  release_channel            = "UNSPECIFIED"
  master_ipv4_cidr_block     = "10.0.0.0/28"
  kubernetes_version         = "1.27.6-gke.1506000"
  logging_enabled_components = ["SYSTEM_COMPONENTS", "APISERVER", "CONTROLLER_MANAGER", "SCHEDULER", "WORKLOADS"]
  # monitoring_enabled_components = ["SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER", "STORAGE", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET"]
  service_account           = google_service_account.gke.email
  remove_default_node_pool  = true

  node_pools = {
   pool1  = {
      name                      = "${local.env}-${local.project}-node-pool"
      machine_type              = "e2-medium"
      # node_locations            = "us-central1-b,us-central1-c"
      autoscaling               = true
      min_count                 = 1
      max_count                 = 10
      local_ssd_count           = 0
      spot                      = true
      disk_size_gb              = 100
      disk_type                 = "pd-ssd"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = true
      logging_variant           = "DEFAULT"
      auto_repair               = true
      auto_upgrade              = false
      service_account           = google_service_account.gke.email
      preemptible               = false
      initial_node_count        = 1
    }
  }

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}