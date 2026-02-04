azure = {
  subscription_id = "0db6d0e6-4adb-4eb0-81fc-ae50560671b8"
  tenant_id       = "c523adee-626c-48b7-b057-b12f85566361"
}

frontdoor_name      = "cargosnap-dev-frontdoor"
resource_group_name = "cargosnap-dev-rg"
location            = "westeurope"
backend_host        = "dev-backend.cargosnap.com"

frontdoor = {
  # Public endpoint settings
  frontend_endpoint_name                  = "frontend-endpoint"
  frontend_host_name                      = "cargosnap-dev-frontdoor.azurefd.net"
  session_affinity_enabled                = false
  session_affinity_ttl_seconds            = 0
  web_application_firewall_policy_link_id = null

  # Routing settings (-> MAP)
  routing_rule_name                = "default-routing-rule"
  routing_rule_accepted_protocols  = ["Https"]
  routing_rule_patterns_to_match   = ["/*"]
  routing_rule_forwarding_protocol = "MatchRequest"

  # Backend pool settings (-> MAP)
  backend = {
    pool_name  = "dev-backend-pool"
    host       = "dev-backend.cargosnap.com"
    http_port  = 80
    https_port = 443
    enabled    = true
    weight     = 50
    priority   = 1
  }

  # Load balancing and health probe settings
  load_balancing_name = "dev-load-balancing-settings"
  health_probe_name   = "dev-health-probe-settings"

  health_probe_protocol            = "Https"
  health_probe_path                = "/"
  health_probe_interval_in_seconds = 30
  health_probe_probe_method        = "HEAD"

  load_balancing_sample_size                     = 4
  load_balancing_successful_samples_required     = 2
  load_balancing_additional_latency_milliseconds = 0
}