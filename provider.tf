# Azure Provider source and version being used
terraform {
  required_version = ">= 1.3"
  backend "azurerm" {
    resource_group_name  = "backend"
    storage_account_name = "backendgithubworkflow"
    container_name       = "tfstate"
    key                  = "actions.tfstate"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.2.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
