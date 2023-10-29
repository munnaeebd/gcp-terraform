resource "google_compute_region_backend_service" "backends" {

  name      = "${var.backend_name}-backend"
  port_name = var.backend_portname
  project   = var.project_id
  protocol  = var.backend_protocol
  load_balancing_scheme   = var.load_balancing_scheme

  health_checks = [var.backend_healthchecks]

  dynamic "backend" {
    for_each = var.backends
    content {
      balancing_mode        = backend.value["balance_mode"]
      capacity_scaler       = backend.value["capacity_scaler"]
      # group                 = var.instance_group_mgr[backend.key].instance_group
      group                 = var.instance_group_mgr
      max_rate_per_instance = backend.value["max_rate_per_instance"]
      max_utilization       = backend.value["max_utilization"]
    }
  }
}
