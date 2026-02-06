variable "azure" {
  type = object({
    subscription_id = string
    tenant_id       = string
  })
  description = "Provide the azure subscription/tenant where the resources should be placed"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "frontdoor" {
  description = "Front Door configuration object."
  type = object({
    profile_name                                 = string
    resource_group_name                          = string
    location                                     = string
    sku_name                                     = string
    endpoint_name                                = string
    origin_group_name                            = string
    load_balancing_sample_size                   = number
    load_balancing_successful_samples_required   = number
    load_balancing_additional_latency_in_milliseconds = number
    health_probe_path                            = string
    health_probe_protocol                        = string
    health_probe_request_type                    = string
    health_probe_interval_in_seconds             = number
    origin_name                                  = string
    backend_host_name                            = string
    backend_http_port                            = number
    backend_https_port                           = number
    origin_host_header                           = string
    origin_priority                              = number
    origin_weight                                = number
    origin_enabled                               = bool
    certificate_name_check_enabled               = bool
    route_name                                   = string
    route_supported_protocols                    = list(string)
    route_patterns_to_match                      = list(string)
    route_forwarding_protocol                    = string
    route_https_redirect_enabled                 = bool
    route_link_to_default_domain                 = bool
    route_enabled                                = bool
    secret_name                                  = string
    secret_id                                    = string
    identity_type                                = string
    identity_ids                                 = list(string)
    certificate_type                                = string
    custom_host_name                              = string
  })
}
