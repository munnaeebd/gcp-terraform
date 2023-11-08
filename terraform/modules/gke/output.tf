# output "cluster_id" {
#   description = "Cluster ID"
#   value       = var.cluster_id
# }

# output "name" {
#   description = "Cluster name"
#   value       = var.cluster_name_computed
#   depends_on = [
#     /* Nominally, the cluster name is populated as soon as it is known to Terraform.
#     * However, the cluster may not be in a usable state yet.  Therefore any
#     * resources dependent on the cluster being up will fail to deploy.  With
#     * this explicit dependency, dependent resources can wait for the cluster
#     * to be up.
#     */
#     google_container_cluster.primary,
#     google_container_node_pool.pools,
#   ]
# }

# output "type" {
#   description = "Cluster type (regional / zonal)"
#   value       = var.cluster_type
# }

# output "location" {
#   description = "Cluster location (region if regional cluster, zone if zonal cluster)"
#   value       = var.cluster_location
# }

# output "region" {
#   description = "Cluster region"
#   value       = var.cluster_region
# }

# output "zones" {
#   description = "List of zones in which the cluster resides"
#   value       = var.cluster_zones
# }

# output "endpoint" {
#   sensitive   = true
#   description = "Cluster endpoint"
#   value       = var.cluster_endpoint
#   depends_on = [
#     /* Nominally, the endpoint is populated as soon as it is known to Terraform.
#     * However, the cluster may not be in a usable state yet.  Therefore any
#     * resources dependent on the cluster being up will fail to deploy.  With
#     * this explicit dependency, dependent resources can wait for the cluster
#     * to be up.
#     */
#     google_container_cluster.primary,
#     google_container_node_pool.pools,
#   ]
# }

# output "min_master_version" {
#   description = "Minimum master kubernetes version"
#   value       = var.cluster_min_master_version
# }

# output "logging_service" {
#   description = "Logging service used"
#   value       = var.cluster_logging_service
# }

# output "monitoring_service" {
#   description = "Monitoring service used"
#   value       = var.cluster_monitoring_service
# }

# output "master_authorized_networks_config" {
#   description = "Networks from which access to master is permitted"
#   value       = google_container_cluster.primary.master_authorized_networks_config
# }

# output "master_version" {
#   description = "Current master kubernetes version"
#   value       = var.cluster_master_version
# }

# output "ca_certificate" {
#   sensitive   = true
#   description = "Cluster ca certificate (base64 encoded)"
#   value       = var.cluster_ca_certificate
# }

# output "network_policy_enabled" {
#   description = "Whether network policy enabled"
#   value       = var.cluster_network_policy_enabled
# }

# output "http_load_balancing_enabled" {
#   description = "Whether http load balancing enabled"
#   value       = var.cluster_http_load_balancing_enabled
# }

# output "horizontal_pod_autoscaling_enabled" {
#   description = "Whether horizontal pod autoscaling enabled"
#   value       = var.cluster_horizontal_pod_autoscaling_enabled
# }

# output "vertical_pod_autoscaling_enabled" {
#   description = "Whether vertical pod autoscaling enabled"
#   value       = var.cluster_vertical_pod_autoscaling_enabled
# }

# output "node_pools_names" {
#   description = "List of node pools names"
#   value       = var.cluster_node_pools_names
# }

# output "node_pools_versions" {
#   description = "Node pool versions by node pool name"
#   value       = var.cluster_node_pools_versions
# }

# output "service_account" {
#   description = "The service account to default running nodes as if not overridden in `node_pools`."
#   value       = var.service_account
# }

# output "instance_group_urls" {
#   description = "List of GKE generated instance groups"
#   value       = distinct(flatten([for np in google_container_node_pool.pools : np.managed_instance_group_urls]))
# }

# output "release_channel" {
#   description = "The release channel of this cluster"
#   value       = var.release_channel
# }

# output "gateway_api_channel" {
#   description = "The gateway api channel of this cluster."
#   value       = var.gateway_api_channel
# }

# output "identity_namespace" {
#   description = "Workload Identity pool"
#   value       = length(var.cluster_workload_identity_config) > 0 ? var.cluster_workload_identity_config[0].workload_pool : null
#   depends_on = [
#     google_container_cluster.primary
#   ]
# }

# output "mesh_certificates_config" {
#   description = "Mesh certificates configuration"
#   value       = var.cluster_mesh_certificates_config
#   depends_on = [
#     google_container_cluster.primary
#   ]
# }


# output "master_ipv4_cidr_block" {
#   description = "The IP range in CIDR notation used for the hosted master network"
#   value       = var.master_ipv4_cidr_block
# }

# output "peering_name" {
#   description = "The name of the peering between this cluster and the Google owned VPC."
#   value       = var.cluster_peering_name
# }