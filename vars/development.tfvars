azure = {
  subscription_id = "0db6d0e6-4adb-4eb0-81fc-ae50560671b8"
  tenant_id       = "c523adee-626c-48b7-b057-b12f85566361"
}

resource_group_name = "example-resource-group"
location            = "westeurope"

frontdoor = {
  profile_name                                 = "cargosnap-frontdoor-dev"
  resource_group_name                          = "example-resource-group"
  location                                     = "westeurope"
  sku_name                                     = "Standard_AzureFrontDoor"
  endpoint_name                                = "frontend-endpoint"
  origin_group_name                            = "cargosnap-frontdoor-dev-origingroup"
  load_balancing_sample_size                   = 4
  load_balancing_successful_samples_required   = 3
  load_balancing_additional_latency_in_milliseconds = 0
  health_probe_path                            = "/"
  health_probe_protocol                        = "Https"
  health_probe_request_type                    = "HEAD"
  health_probe_interval_in_seconds             = 30
  origin_name                                  = "origin-1"
  backend_host_name                            = "dev-backend.cargosnap.com"
  backend_http_port                            = 80
  backend_https_port                           = 443
  origin_host_header                           = null
  origin_priority                              = 1
  origin_weight                                = 100
  origin_enabled                               = true
  certificate_name_check_enabled               = true
  route_name                                   = "default-route"
  route_supported_protocols                    = ["Http", "Https"]
  route_patterns_to_match                      = ["/*"]
  route_forwarding_protocol                    = "HttpsOnly"
  route_https_redirect_enabled                 = true
  route_link_to_default_domain                 = true
  route_enabled                                = true
  secret_name                                  = "cargosnap-frontdoor-dev-secret"
  secret_id                                    = "https://kv-cargosnap-bitscloud.vault.azure.net/certificates/bitscloud"
}