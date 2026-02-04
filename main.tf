terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.azure.subscription_id
  tenant_id = var.azure.tenant_id

  features {}
}

module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "frontdoor" {
  source = "./modules/frontdoor"

  name = var.frontdoor.profile_name
  frontdoor           = var.frontdoor
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  depends_on = [module.resource_group]
}
