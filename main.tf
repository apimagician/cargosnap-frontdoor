terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "frontdoor" {
  source              = "./modules/frontdoor"

  frontdoor           = var.frontdoor
  name                = var.frontdoor_name
  resource_group_name = var.resource_group_name
  location            = var.location
}
