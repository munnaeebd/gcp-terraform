
module "memstore" {
  source = "./modules/redis"
  count = 0
  name = "${local.env}-${local.project}-redis"

  project_id              = local.project_id
  region                  = local.region
  # location_id             = local.region
  # alternative_location_id = "us-east1-d"
  # enable_apis             = true
  replica_count           = 1
  read_replicas_mode      = "READ_REPLICAS_ENABLED"
  auth_enabled            = false
  transit_encryption_mode = "DISABLED"
  authorized_network      = module.vpc.network
  redis_version           = local.redis_version
  memory_size_gb          = local.memory_size_gb
  # persistence_config = {
  #   persistence_mode    = "RDB"
  #   rdb_snapshot_period = "ONE_HOUR"
  # }
}