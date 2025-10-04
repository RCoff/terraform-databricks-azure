resource "azurerm_virtual_network" "spoke-data_infra" {
  name                = "vnet-${local.env}-${var.location_abbreviation}-data-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name

  address_space = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network_peering" "hub--to--spoke-data_infra" {
  name                      = "peer-${local.env}-${var.location_abbreviation}-data-01"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke-data_infra.id
}

resource "azurerm_virtual_network" "spoke-databricks" {
  name                = "vnet-${local.env}-${var.location_abbreviation}-databricks-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name

  address_space = ["10.2.0.0/16"]
}

resource "azurerm_virtual_network_peering" "hub--to--spoke-databricks" {
  name                      = "peer-${local.env}-${var.location_abbreviation}-databricks-01"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke-databricks.id
}
