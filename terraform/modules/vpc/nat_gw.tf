resource "google_compute_router" "router" {
  name    = "${var.common_name}-router"
  network = google_compute_network.network.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.common_name}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  # log_config {
  #   enable = false
  #   filter = "ERRORS_ONLY"
  # }
}