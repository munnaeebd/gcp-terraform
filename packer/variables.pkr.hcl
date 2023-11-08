variable "zone" {
  type        = string
  default     = "asia-southeast1-b"
}
variable "project_id" {
  type        = string
  default     = "munna-rnd"
}
variable "machine_type" {
  type        = string
  default     = "e2-small"
}

variable "env" {
  type        = string
  default     = ""
}
variable "modules" {
  type        = string
  default     = ""
}
variable "source_image" {
  type        = string
  default     = "ubuntu-2204-lts"
}