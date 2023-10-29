

variable "urlmap_name" {
  type        = string
  description = "urlmap_name"
  default     = "urlmap_name"
}
variable "proxy_name" {
  type        = string
  description = "proxy_name"
  default     = "proxy_name"
}

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}

variable "forwarding_rules" {}

####################
# network_interface
####################
variable "network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  type        = string
  default     = ""
}
variable "path_rule" {}
variable "default_backend" {}

variable "name" {
  type        = string
  description = "common name"
  default     = ""
}
variable "hosts" {
  type        = list(string)
  description = "common name"
  default     = []
}
