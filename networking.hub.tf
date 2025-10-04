resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${local.env}-${var.location_abbreviation}-hub-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_private_dns_zone" "storage_account_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_private_dns_zone" "storage_account_dfs" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_private_dns_zone" "key_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_account_blob" {
  name                  = "link-${local.env}-${var.location_abbreviation}-storage_account_blob-01"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account_blob.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_account_dfs" {
  name                  = "link-${local.env}-${var.location_abbreviation}-storage_account_dfs-01"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_account_dfs.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault" {
  name                  = "link-${local.env}-${var.location_abbreviation}-key_vault-01"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.key_vault.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}
