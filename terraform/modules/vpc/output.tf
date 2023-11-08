# output "subnets" {
#   # value       = google_compute_subnetwork.subnetwork.name
#   # value = [for subnet in keys(var.subnets) : google_compute_subnetwork.subnetwork[subnet].name]
#     value = {
#     for k, subnet in google_compute_subnetwork.subnetwork : k => subnet.name if subnet.purpose == "PRIVATE"
#     # for key, subnet in google_compute_subnetwork.subnetwork : key => lookup(subnet.name, key)
#   }
# }

# output "proxy_subnets" {
#   # value       = google_compute_subnetwork.subnetwork.name
#   # value = [for subnet in keys(var.subnets) : google_compute_subnetwork.subnetwork[subnet].name]
#     value = {
#     for k, subnet in google_compute_subnetwork.subnetwork : k => subnet.name if subnet.purpose == "REGIONAL_MANAGED_PROXY"
#     # for key, subnet in google_compute_subnetwork.subnetwork : key => lookup(subnet.name, key)
#   }
# }
output "subnets" {
  # value       = google_compute_subnetwork.subnetwork.name
  # value = [for subnet in keys(var.subnets) : google_compute_subnetwork.subnetwork[subnet].name]
    # value = {
    # for k, subnet in google_compute_subnetwork.subnetwork : k => subnet.name if subnet.purpose == "REGIONAL_MANAGED_PROXY"
    # for key, subnet in google_compute_subnetwork.subnetwork : key => lookup(subnet.name, key)
  # value       = google_compute_subnetwork.subnetwork
  # value = element(values(google_compute_subnetwork.subnetwork), 0)["name"] 
  value = {for subnet in google_compute_subnetwork.subnetwork : subnet.purpose => subnet.id}
  
}

output "private_ipv4_cidr" {
  # value       = google_compute_subnetwork.subnetwork.name
  # value = [for subnet in keys(var.subnets) : google_compute_subnetwork.subnetwork[subnet].name]
    # value = {
    # for k, subnet in google_compute_subnetwork.subnetwork : k => subnet.name if subnet.purpose == "REGIONAL_MANAGED_PROXY"
    # for key, subnet in google_compute_subnetwork.subnetwork : key => lookup(subnet.name, key)
  # value       = google_compute_subnetwork.subnetwork
  # value = element(values(google_compute_subnetwork.subnetwork), 0)["name"] 
  value = {for subnet in google_compute_subnetwork.subnetwork : subnet.purpose => subnet.ip_cidr_range}
  
}

output "network" {
  value       = google_compute_network.network.id
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}
