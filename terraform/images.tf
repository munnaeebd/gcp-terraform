module "module-1-image" {
  source   = "./modules/image"
  image_name = "${local.env}-module-1-*"
  project_id           = local.project_id

  # owner    = ["self"]
}

# module "module-2-image" {
#   source   = "./modules/image"
#   image_name = "${local.env}-module-2-*"
#   # owner    = ["self"]
# }