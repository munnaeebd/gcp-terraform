resource "google_compute_network" "network" {
  name                                      = var.network_name
  auto_create_subnetworks                   = var.auto_create_subnetworks
  routing_mode                              = var.routing_mode
  project                                   = var.project_id
  description                               = var.description
  delete_default_routes_on_create           = var.delete_default_internet_gateway_routes
  mtu                                       = var.mtu
  enable_ula_internal_ipv6                  = var.enable_ipv6_ula
  internal_ipv6_range                       = var.internal_ipv6_range
  network_firewall_policy_enforcement_order = var.network_firewall_policy_enforcement_order
}

/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  provider = google-beta

  count      = var.shared_vpc_host ? 1 : 0
  project    = var.project_id
  depends_on = [google_compute_network.network]
}
resource "google_compute_firewall" "firewall_rules" {

  # Get count for firewall rules to create
  # count = length(var.firewall_rules)

  # Firewall rule network - Single network for all firewall rules
  network = google_compute_network.network.name

  name = "${var.common_name}-rule-for-iap"
  # Protocals & ports
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  # Source CIDR ranges
  source_ranges = ["35.235.240.0/20"]
  # Target tags
  target_tags = var.iap_rule_target_tag

  # Priority
  # priority = var.priority

}