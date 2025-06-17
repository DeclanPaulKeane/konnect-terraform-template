terraform {
  required_providers {
    konnect = {
      source = "kong/konnect"
      version = "~> 2.8.1"
    }
    konnect-beta = {
      source = "kong/konnect-beta"
    }
  }
}

provider "konnect" {
  personal_access_token = var.konnect_pat
  server_url           = var.konnect_server_url
}

provider "konnect-beta" {
  personal_access_token = var.konnect_pat
  server_url            = var.konnect_server_url
}

resource "konnect_gateway_control_plane" "control_plane" {
  name         = var.control_plane_name
  description  = var.control_plane_description
  cluster_type = "CLUSTER_TYPE_CONTROL_PLANE"
  auth_type    = "pinned_client_certs"
}
# External service
module "external_service" {
  source = "./services/external-service"

  control_plane_id = konnect_gateway_control_plane.control_plane.id
  portal_id        = var.portal_id
} 