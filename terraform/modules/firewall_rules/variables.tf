variable "name" {
  type        = string
  default     = ""
}
variable "network" {
  type        = string
  default     = "network"
}
variable "port" {}
variable "source_ranges" {}

variable "target_tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "priority" {
  type        = number
  default     = null
}
