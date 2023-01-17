variable "region" {
  type        = string
  description = "Region your P1 Org is in"
}

variable "organization_id" {
  type        = string
  description = "Your Organization ID"
  sensitive = true
}

variable "admin_env_id" {
  type        = string
  description = "P1 Administrators Environment containing the Admin User and Worker App"
}

variable "admin_user_id" {
  type        = string
  description = "Admin User ID for Role Assignment"
}

variable "admin_user_name" {
  type        = string
  description = "Admin Username for the DV provider"
}

variable "admin_user_password" {
  type        = string
  description = "Admin User password for the DV provider"
  sensitive = true
}

variable "worker_id" {
  type        = string
  description = "Worker App ID App - App must have sufficient Roles"
  sensitive = true
}

variable "worker_secret" {
  type        = string
  description = "Worker App Secret - App must have sufficient Roles"
  sensitive = true
}

variable "deploy_name" {
  type        = string
  description = "Name used for the deployment"
}