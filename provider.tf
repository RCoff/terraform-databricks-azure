terraform {
  required_version = "~> 1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.47"
    }
  }
}

provider "azurerm" {
  features {}

  # Enable Azure AD integration for storage account
  #   This is required as we will be disabling access key authentication on the storage account
  storage_use_azuread = true
}
