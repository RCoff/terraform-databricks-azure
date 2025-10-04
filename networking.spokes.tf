# Data Infrastructure Networking
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


resource "azurerm_subnet" "data_infra_common-01" {
  # This subnet is intended for all data infrastructure services that do not require dedicated subnets.
  name                 = "snet-${local.env}-${var.location_abbreviation}-data_infra_common-01"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.spoke-data_infra.name
  address_prefixes     = ["10.1.0.0/24"]
}


resource "azurerm_private_endpoint" "storage_account_data_lake-blob" {
  name                = "pep-${local.env}-${var.location_abbreviation}-data_lake_blob-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  subnet_id           = azurerm_subnet.data_infra_common-01.id

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.env}-${var.location_abbreviation}-data_lake_blob-01"
    private_connection_resource_id = azurerm_storage_account.data_lake.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "storage_blob"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage_account_blob.id]
  }
}

resource "azurerm_private_endpoint" "storage_account_data_lake-dfs" {
  name                = "pep-${local.env}-${var.location_abbreviation}-data_lake_dfs-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  subnet_id           = azurerm_subnet.data_infra_common-01.id

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.env}-${var.location_abbreviation}-data_lake_dfs-01"
    private_connection_resource_id = azurerm_storage_account.data_lake.id
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = "storage_dfs"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage_account_dfs.id]
  }
}

# Databricks Networking
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
