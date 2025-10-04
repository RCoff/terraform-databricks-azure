terraform {
  required_version = "~> 1.10"

    required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~> 4.47"
        }
        databricks = {
            source  = "databricks/databricks"
            version = "~> 1.91"
        }
    }
}