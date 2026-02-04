variable "azure" {
  type = object({
    subscription_id = string
    tenant_id       = string
  })

  description = "Provide the azure subscription/tenant where the resources should be placed"
}

variable "frontdoor_name" {
  description = "The name of the Front Door instance."
  type        = string
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
  description = "The backend host for Front Door."
  type        = any
}
