resource "google_compute_region_url_map" "url_map" {

  name    = "${var.name}-url-map"
  project = var.project_id
  default_service = var.default_backend

  host_rule {
    hosts        = var.hosts
    path_matcher = "mnpath"
  }

  path_matcher {
    name            = "mnpath"
    default_service = var.default_backend

    dynamic "path_rule" {
      for_each = var.path_rule
      content {
        paths        = path_rule.value["paths"]
        service      = path_rule.value["service"]
      }
    }
  }

}
resource "google_compute_region_target_http_proxy" "proxy" {

  name    = "${var.name}-proxy"
  project = var.project_id

  url_map = google_compute_region_url_map.url_map.id
}

resource "google_compute_forwarding_rule" "http" {

  # Count for list of group managers
  count = length(var.forwarding_rules)

  project = var.project_id
  target  = google_compute_region_target_http_proxy.proxy.id

  name                  = var.forwarding_rules[count.index].forwardingrule_name
  ip_protocol           = var.forwarding_rules[count.index].forwardingrule_protocol
  load_balancing_scheme = var.forwarding_rules[count.index].load_balancing_scheme
  port_range            = var.forwarding_rules[count.index].port_range
  network               = var.network
  network_tier          = "STANDARD"

}