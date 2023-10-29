
####################
# Instance Template
####################
resource "google_compute_region_instance_template" "tpl" {
  name                    = var.name
  project                 = var.project_id
  machine_type            = var.machine_type
  labels                  = var.labels
  tags                    = var.tags
  can_ip_forward          = var.can_ip_forward
  metadata_startup_script = var.startup_script
  region                  = var.region
  min_cpu_platform        = var.min_cpu_platform
  resource_policies       = var.resource_policies
  disk {
    source_image      = var.source_image
    auto_delete = false
    boot        = true
    disk_type   = var.disk_type
    disk_size_gb  = var.disk_size_gb
  }

  service_account {
    email   = var.service_account_email
    scopes  = ["cloud-platform"]
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    network_ip         = length(var.network_ip) > 0 ? var.network_ip : null
    nic_type           = var.nic_type
    stack_type         = var.stack_type
    # dynamic "access_config" {
    #   for_each = var.access_config
    #   content {
    #     nat_ip       = access_config.value.nat_ip
    #     network_tier = access_config.value.network_tier
    #   }
    # }
  }

  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      set -euo pipefail

      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get install -y nginx-light jq

      NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
      IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
      METADATA=$(curl -f -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=True" | jq 'del(.["startup-script"])')

      cat <<EOF > /var/www/html/index.html
      <pre>
      Name: $NAME
      IP: $IP
      Metadata: $METADATA
      </pre>
      EOF
    EOF1
  }

  lifecycle {
    create_before_destroy = "true"
  }

  scheduling {
    preemptible                 = var.preemptible
    automatic_restart           = var.automatic_restart
    on_host_maintenance         = var.on_host_maintenance
    provisioning_model          = var.spot ? "SPOT" : null
    instance_termination_action = var.spot ? var.spot_instance_termination_action : null
  }
}