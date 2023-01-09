module "environment" {
  source  = "terraform-pingidentity-modules/environment/pingone"
  version = "0.0.12"

  target_environment_name = var.deploy_name

  admin_user_assign_environment_admin_role = false
  admin_user_assign_identity_admin_role = true
  admin_user_id_list = [
    var.admin_user_id
  ]
  create_authorize = true
  create_davinci = true
  create_risk = true
  license_name = "INTERNAL"
  organization_id = var.organization_id
}

##############################################
# Additional HCL 
##############################################
provider "pingone" {
  client_id                    = var.worker_id
  client_secret                = var.worker_secret
  environment_id               = var.admin_env_id
  region                       = var.region
  force_delete_production_type = false
}

data "pingone_schema" "users" {
  environment_id = module.environment.environment_id

  name = "User"
}

data "pingone_environment" "created_env" {
  environment_id = module.environment.environment_id
}

resource "pingone_schema_attribute" "parent_id" {
  environment_id = module.environment.environment_id
  schema_id      = data.pingone_schema.users.id

  name         = "parent"
  display_name = "Parent ID"
  description  = "ID of the Child's Parent"

  type        = "STRING"
  unique      = false
  multivalued = false
}

resource "pingone_schema_attribute" "children_ids" {
  environment_id = module.environment.environment_id
  schema_id      = data.pingone_schema.users.id

  name         = "children"
  display_name = "Children IDs"
  description  = "IDs and limits of the Parent's children"
  # [{"id": "abb87055-3634-4c5e-ae3d-a7b12bca9aff", "limit": 100},{"id": "5c4c9d71-c7c7-4212-95c5-e2aa798b9afa", "limit": 200}]

  type        = "JSON"
  unique      = false
  multivalued = true
}

resource "pingone_population" "sko" {
  environment_id = module.environment.environment_id

  name        = "SKO2023 Users"
  description = "Users created by Terraform"
}

resource "pingone_user" "parent" {
  environment_id = module.environment.environment_id
  population_id = pingone_population.sko.id

  username = "parent"
  email    = "parent@mailinator.com"
}

resource "pingone_user" "child1" {
  environment_id = module.environment.environment_id
  population_id = pingone_population.sko.id

  username = "child1"
  email    = "child1@mailinator.com"
}

resource "pingone_user" "child2" {
  environment_id = module.environment.environment_id
  population_id = pingone_population.sko.id

  username = "child2"
  email    = "child2@mailinator.com"
}