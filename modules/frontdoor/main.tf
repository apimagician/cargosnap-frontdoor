resource "azurerm_frontdoor" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  frontend_endpoint {
    name                                    = var.frontdoor.frontend_endpoint_name
    host_name                               = var.frontdoor.frontend_host_name
    session_affinity_enabled                = var.frontdoor.session_affinity_enabled
    session_affinity_ttl_seconds            = var.frontdoor.session_affinity_ttl_seconds
    web_application_firewall_policy_link_id = var.frontdoor.web_application_firewall_policy_link_id
  }

  backend_pool {
    name = var.frontdoor.backend.pool_name

    backend {
      host_header = var.frontdoor.backend.host
      address     = var.frontdoor.backend.host
      http_port   = var.frontdoor.backend.http_port
      https_port  = var.frontdoor.backend.https_port
      enabled     = var.frontdoor.backend.enabled
      weight      = var.frontdoor.backend.weight
      priority    = var.frontdoor.backend.priority
    }

    load_balancing_name = var.frontdoor.load_balancing_name
    health_probe_name   = var.frontdoor.health_probe_name
  }

  backend_pool_health_probe {
    name                = var.frontdoor.health_probe_name
    protocol            = var.frontdoor.health_probe_protocol
    path                = var.frontdoor.health_probe_path
    interval_in_seconds = var.frontdoor.health_probe_interval_in_seconds
    probe_method        = var.frontdoor.health_probe_probe_method
  }

  backend_pool_load_balancing {
    name                            = var.frontdoor.load_balancing_name
    sample_size                     = var.frontdoor.load_balancing_sample_size
    successful_samples_required     = var.frontdoor.load_balancing_successful_samples_required
    additional_latency_milliseconds = var.frontdoor.load_balancing_additional_latency_milliseconds
  }

  routing_rule {
    name               = var.frontdoor.routing_rule_name
    accepted_protocols = var.frontdoor.routing_rule_accepted_protocols
    patterns_to_match  = var.frontdoor.routing_rule_patterns_to_match
    frontend_endpoints = [var.frontdoor.frontend_endpoint_name]
    forwarding_configuration {
      forwarding_protocol = var.frontdoor.routing_rule_forwarding_protocol
      backend_pool_name   = var.frontdoor.backend.pool_name
    }
  }
}
