variable "konnect_pat" {
  description = "Kong Konnect Personal Access Token"
  type        = string
  sensitive   = true
}

variable "konnect_server_url" {
  description = "Kong Konnect API server URL"
  type        = string
  default     = "https://us.api.konghq.com"
}

variable "control_plane_name" {
  description = "Name of the control plane"
  type        = string
}

variable "control_plane_description" {
  description = "Description of the control plane"
  type        = string
}

variable "portal_id" {
  description = "The ID of the portal for API publication"
  type        = string
} 