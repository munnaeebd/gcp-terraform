resource "google_compute_firewall" "firewall_rules" {

  # Get count for firewall rules to create
  # count = length(var.firewall_rules)

  # Firewall rule network - Single network for all firewall rules
  network = var.network

  name = "${var.name}-rule"
  # Protocals & ports
  allow {
    protocol = "tcp"
    ports    = var.port
  }
  # Source CIDR ranges
  source_ranges = var.source_ranges
  # Target tags
  target_tags = var.target_tags

  # Priority
  priority = var.priority

}