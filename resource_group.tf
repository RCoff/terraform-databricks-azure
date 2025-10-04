# Create 3 resource groups
#   - Networking & DNS
#   - Common Data Infrastructure
#   - Databricks Workspace
#
# Naming convention: rg-<env>-<location_abbreviation>-<purpose>-<numeric_suffix>
#   Example: "rg-d-eus-network-01" for a 'dev' environment in 'East US' for networking resources
#   The numeric suffix allows for future expansion if multiple resource groups are needed for the same purpose.


resource "azurerm_resource_group" "network" {
  name     = "rg-${local.env}-${var.location_abbreviation}-network-01"
  location = var.location
  tags     = local.networking_tags
}


resource "azurerm_resource_group" "data_infra" {
  name     = "rg-${local.env}-${var.location_abbreviation}-data-01"
  location = var.location
  tags     = local.data_infra_tags
}


resource "azurerm_resource_group" "databricks" {
  name     = "rg-${local.env}-${var.location_abbreviation}-databricks-01"
  location = var.location
  tags     = local.databricks_tags
}
