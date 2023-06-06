terraform {
  backend "azurerm" {
    resource_group_name  = "backend"
    storage_account_name = "backendgithubworkflow"
    container_name       = "tfstate"
    key                  = "actions.tfstate"
    subscription_id = "77be15c3-5849-4192-956e-e693d7ae0897"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.51.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
