output "frontdoor_id" {
  value = azurerm_frontdoor.this.id
}

output "frontend_endpoint" {
  value = azurerm_frontdoor_frontend_endpoint.this.host_name
}
