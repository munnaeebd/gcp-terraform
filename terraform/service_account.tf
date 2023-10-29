resource "google_service_account" "module_1" {
  account_id   = "${local.env}-${local.project}-module-1"
  display_name = "${local.env}-${local.project}-module-1"
}   
resource "google_service_account" "module_2" {
  account_id   = "${local.env}-${local.project}-module-2"
  display_name = "${local.env}-${local.project}-module-2"
}   