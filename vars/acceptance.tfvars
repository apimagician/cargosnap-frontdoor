frontdoor_name      = "cargosnap-acc-frontdoor"
resource_group_name = "cargosnap-acc-rg"
location            = "westeurope"
backend_host        = "acc-backend.cargosnap.com"

frontdoor = {
  # Public endpoint settings
  frontend_endpoint_name                  = "frontend-endpoint"
  frontend_host_name                      = "cargosnap-acc-frontdoor.azurefd.net"
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
    pool_name  = "acc-backend-pool"
    host       = "acc-backend.cargosnap.com"
    http_port  = 80
    https_port = 443
    enabled    = true
    weight     = 50
    priority   = 1
  }

  # Load balancing and health probe settings
  load_balancing_name = "acc-load-balancing-settings"
  health_probe_name   = "acc-health-probe-settings"

  health_probe_protocol            = "Https"
  health_probe_path                = "/"
  health_probe_interval_in_seconds = 30
  health_probe_probe_method        = "HEAD"

  load_balancing_sample_size                     = 4
  load_balancing_successful_samples_required     = 2
  load_balancing_additional_latency_milliseconds = 0
}
