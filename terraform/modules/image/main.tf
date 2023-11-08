data "google_compute_image" "my_image" {
  most_recent = true
  project = var.project_id
  filter = "(name=${var.image_name})"
}