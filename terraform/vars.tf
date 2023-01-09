variable "region" {
  type        = string
  description = "Region your P1 Org is in"
}

variable "organization_id" {
  type        = string
  description = "Your Organization ID"
}

variable "admin_env_id" {
  type        = string
  description = "P1 Administrators Environment containing the Admin User and Worker App"
}

variable "admin_user_id" {
  type        = string
  description = "Admin User ID for Role Assignment"
}

variable "worker_id" {
  type        = string
  description = "Worker App ID App - App must have sufficient Roles"
}

variable "worker_secret" {
  type        = string
  description = "Worker App Secret - App must have sufficient Roles"
}

variable "deploy_name" {
  type        = string
  description = "Name used for the deployment"
}