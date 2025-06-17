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


resource "konnect_gateway_service" "external_service" {
  name             = "external-service"
  protocol         = "https"
  host             = "httpbin.org"
  port             = 443
  path             = "/"
  control_plane_id = var.control_plane_id
}

resource "konnect_gateway_route" "external_route" {
  name             = "external-route"
  paths            = ["/anything"]
  methods          = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
  strip_path       = false
  control_plane_id = var.control_plane_id
  service = {
    id = konnect_gateway_service.external_service.id
  }
} 

resource "konnect_gateway_plugin_cors" "external_cors" {
  enabled = true

  config = {
    origins = ["https://api-example.kong-sales-engineering.com"]
    methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    headers = ["Accept", "Accept-Version", "Content-Length", "Content-MD5", "Content-Type", "Date", "X-Auth-Token"]
    credentials = true
    max_age = 3600
  }

  control_plane_id = var.control_plane_id
  service = {
    id = konnect_gateway_service.external_service.id
  }
}

resource "konnect_api" "httpbin_api" {
  provider    = konnect-beta
  name        = "Httpbin API Terraform"
  version     = "v1"
  description = "This is a description of a httpbin  API"
  labels = {
    key = "value"
  }
}

resource "konnect_api_implementation" "my_apiimplementation" {
  provider = konnect-beta
  api_id   = konnect_api.httpbin_api.id
  service = {
    control_plane_id = var.control_plane_id
    id               = konnect_gateway_service.external_service.id
  }
}


resource "konnect_api_publication" "my_apipublication" {
  provider                   = konnect-beta
  api_id                     = konnect_api.httpbin_api.id
  portal_id                  = var.portal_id
  auto_approve_registrations = true
  visibility                 = "private"
}

resource "konnect_api_specification" "my_apispecification" {
  provider = konnect-beta
  api_id   = konnect_api.httpbin_api.id
  content  = file("${path.module}/specifications/httpbin.yaml")
  type     = "oas3"
}