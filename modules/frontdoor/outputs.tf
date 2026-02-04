output "frontdoor_id" {
  value = azurerm_frontdoor.this.id
}

output "frontend_endpoint" {
  value = azurerm_frontdoor.this.frontend_endpoint[0].host_name
}

