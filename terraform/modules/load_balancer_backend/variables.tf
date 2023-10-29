# backend service name
variable "backend_name" {
  type        = string
  description = "Backend Name"
  default     = null
}
# Back end port name
variable "backend_portname" {
  type        = string
  description = "Backend Port Name"
  default     = null
}
# backend associated project
variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}
# backend protocal 
variable "backend_protocol" {
  type        = string
  default     = null
}
# backend health checks
variable backend_healthchecks {}

# instance group managers
variable instance_group_mgr {}

# backend list 
variable backends {}

variable "load_balancing_scheme" {
  type        = string
  description = "load_balancing_scheme"
  default     = "EXTERNAL_MANAGED"
}


# variable "backends" {
#   description = "backend"
#   type = list(object({
#     interface_name = string
#     delete_rule    = string
#     is_external    = bool
#   }))
#   default = []
# }