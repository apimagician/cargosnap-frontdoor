# Remove references to deprecated azurerm_frontdoor resource
# You can add outputs for the new resources if needed
output "frontdoor_id" {
  value = azurerm_cdn_frontdoor_profile.this.id
}

output "frontend_endpoint" {
  value = azurerm_cdn_frontdoor_endpoint.this.name
}

