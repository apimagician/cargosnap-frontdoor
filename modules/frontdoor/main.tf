# Front Door Standard profile
resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = var.frontdoor.profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.frontdoor.sku_name

  identity {
    type = var.frontdoor.identity_type
    identity_ids = var.frontdoor.identity_ids
  }
}

# Endpoint
resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = var.frontdoor.endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}

# Origin group (backend pool)
resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = var.frontdoor.origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  load_balancing {
    sample_size                        = var.frontdoor.load_balancing_sample_size
    successful_samples_required        = var.frontdoor.load_balancing_successful_samples_required
    additional_latency_in_milliseconds = var.frontdoor.load_balancing_additional_latency_in_milliseconds
  }

  health_probe {
    path                = var.frontdoor.health_probe_path
    protocol            = var.frontdoor.health_probe_protocol
    request_type        = var.frontdoor.health_probe_request_type
    interval_in_seconds = var.frontdoor.health_probe_interval_in_seconds
  }
}

# Enkele origin (jouw web URL)
resource "azurerm_cdn_frontdoor_origin" "this" {
  name                          = var.frontdoor.origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id

  host_name                        = var.frontdoor.backend_host_name
  http_port                        = var.frontdoor.backend_http_port
  https_port                       = var.frontdoor.backend_https_port
  origin_host_header               = coalesce(var.frontdoor.origin_host_header, var.frontdoor.backend_host_name)
  priority                         = var.frontdoor.origin_priority
  weight                           = var.frontdoor.origin_weight
  enabled                          = var.frontdoor.origin_enabled
  certificate_name_check_enabled   = var.frontdoor.certificate_name_check_enabled
}

# Route (alles naar je backend, HTTPS‑only)
resource "azurerm_cdn_frontdoor_route" "this" {
  name                          = var.frontdoor.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.this.id]

  supported_protocols      = var.frontdoor.route_supported_protocols
  patterns_to_match        = var.frontdoor.route_patterns_to_match
  forwarding_protocol      = var.frontdoor.route_forwarding_protocol
  https_redirect_enabled   = var.frontdoor.route_https_redirect_enabled
  link_to_default_domain   = var.frontdoor.route_link_to_default_domain
  enabled                  = var.frontdoor.route_enabled
}

# Create secret for custom domain HTTPS
resource "azurerm_cdn_frontdoor_secret" "this" {
  name                     = var.frontdoor.secret_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  secret {
    customer_certificate {
      key_vault_certificate_id = var.frontdoor.secret_id
    }
  }

  depends_on = [ azurerm_cdn_frontdoor_endpoint.this ]
}