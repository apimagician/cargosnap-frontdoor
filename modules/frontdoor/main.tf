resource "azurerm_frontdoor" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  frontend_endpoint {
    name                              = "frontend-endpoint"
    host_name                         = "${var.name}.azurefd.net"
    session_affinity_enabled          = false
    session_affinity_ttl_seconds      = 0
    web_application_firewall_policy_link_id = null
  }

  backend_pool {
    name = "backend-pool"

    backend {
      host_header = var.backend_host
      address     = var.backend_host
      http_port   = 80
      https_port  = 443
      enabled     = true
      weight      = 50
      priority    = 1
    }

    load_balancing_name = "load-balancing-settings"
    health_probe_name   = "health-probe-settings"
  }

  backend_pool_health_probe {
    name                = "health-probe-settings"
    protocol            = "Https"
    path                = "/"
    interval_in_seconds = 30
    probe_method        = "HEAD"
  }

  backend_pool_load_balancing {
    name                            = "load-balancing-settings"
    sample_size                     = 4
    successful_samples_required      = 2
    additional_latency_milliseconds = 0
  }

  routing_rule {
    name               = "default-routing-rule"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontend-endpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "backend-pool"
    }
  }
}

# The frontend_endpoint and backend_pool resources are now defined inline in the azurerm_frontdoor resource above.
