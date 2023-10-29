resource "google_service_account" "s3_access" {
  account_id   = "${local.env}-${local.project}-s3-access"
  display_name = "${local.env}-${local.project}-s3-access"
}    

resource "google_project_iam_custom_role" "s3_role" {
  role_id     = "${local.env}_${local.project}_s3_role"
  title       = "${local.env}-${local.project}-s3-role"
  description = "${local.env}-${local.project}-s3-role"
  permissions = ["iam.roles.list", 
                 "iam.roles.create", 
                 "iam.roles.delete",
                 "storage.objects.get",
                 "storage.objects.list"
                ]
}

resource "google_project_iam_member" "s3_binding" {
  project = local.project_id
  role               = google_project_iam_custom_role.s3_role.id
  member = "serviceAccount:${google_service_account.s3_access.email}"
}