locals {
  subnets = {
    for x in var.subnets :
    "${x.subnet_region}/${x.subnet_name}" => x
  }
}

resource "google_compute_subnetwork" "subnetwork" {

  for_each                   = local.subnets
  name                       = each.value.subnet_name
  ip_cidr_range              = each.value.subnet_ip
  region                     = each.value.subnet_region
  private_ip_google_access   = lookup(each.value, "subnet_private_access", "false")
  private_ipv6_google_access = lookup(each.value, "subnet_private_ipv6_access", null)
  dynamic "log_config" {
    for_each = coalesce(lookup(each.value, "subnet_flow_logs", null), false) ? [{
      aggregation_interval = each.value.subnet_flow_logs_interval
      flow_sampling        = each.value.subnet_flow_logs_sampling
      metadata             = each.value.subnet_flow_logs_metadata
      filter_expr          = each.value.subnet_flow_logs_filter
      metadata_fields      = each.value.subnet_flow_logs_metadata_fields
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      filter_expr          = log_config.value.filter_expr
      metadata_fields      = log_config.value.metadata == "CUSTOM_METADATA" ? log_config.value.metadata_fields : null
    }
  }
  network     = google_compute_network.network.id
  project     = var.project_id
  description = lookup(each.value, "description", null)
  secondary_ip_range = [
    for i in range(
      length(
        contains(
        keys(var.secondary_ranges), each.value.subnet_name) == true
        ? var.secondary_ranges[each.value.subnet_name]
        : []
    )) :
    var.secondary_ranges[each.value.subnet_name][i]
  ]

  purpose          = lookup(each.value, "purpose", null)
  role             = lookup(each.value, "role", null)
  stack_type       = lookup(each.value, "stack_type", null)
  ipv6_access_type = lookup(each.value, "ipv6_access_type", null)
}

# resource "google_compute_global_address" "private_service_connect" {
#   provider     = google-beta
#   project      = var.project_id
#   name         = "test"
#   address_type = "INTERNAL"
#   purpose      = "PRIVATE_SERVICE_CONNECT"
#   network      = google_compute_network.network.id
#   address      = "10.10.201.0/24"
# }

########## Create Private Service Access:
resource "google_project_service" "service_networking" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
  project            = var.project_id
}
resource "google_compute_global_address" "private_ip_alloc" {
  name          = var.service_subnet_name
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  address       = var.service_subnet
  network       = google_compute_network.network.id
}

########### Create a VPC Peering Connection:
resource "google_service_networking_connection" "private_access_connection" {
  network                 = google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

# resource "google_compute_subnetwork" "subnetwork" {
#   name                       = "${var.common_name}-subnet"
#   ip_cidr_range              = var.subnets
#   # region                     = var.subnet_region
#   # private_ip_google_access   = var.google_private_access
#   network     = google_compute_network.network.id
#   project     = var.project_id
#   description = "${var.common_name}-subnet"
#   # purpose          = lookup(each.value, "purpose", null)
#   # role             = lookup(each.value, "role", null)
#   # stack_type       = lookup(each.value, "stack_type", null)
#   # ipv6_access_type = lookup(each.value, "ipv6_access_type", null)
# }