resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${local.env}-${var.location_abbreviation}-hub-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name

  address_space = ["10.0.0.0/16"]
}
