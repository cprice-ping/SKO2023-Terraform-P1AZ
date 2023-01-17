provider "davinci" {
  //Must be Identity Data Admin for Environment 
  username = var.admin_user_name
  password = var.admin_user_password
  region   = var.region
  // User should exist in Identities of this environment
  environment_id = vars.admin_env_id
}