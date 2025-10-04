resource "azurerm_storage_account" "data_lake" {
  name                            = "st${local.env}${var.location_abbreviation}datalake01"
  resource_group_name             = azurerm_resource_group.data_infra.name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "ZRS"
  account_kind                    = "StorageV2"
  access_tier                     = "Hot"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  # Enable hierarchical namespace for Data Lake Storage Gen2 capabilities
  is_hns_enabled = true

  # Disable access key authentication to require Azure AD authentication
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  local_user_enabled              = false

  # Enable secure transfer required
  infrastructure_encryption_enabled = true

  public_network_access_enabled = false

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = []
  }

  blob_properties {
    last_access_time_enabled = true

    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_container" "container" {
  for_each = toset([
    "bronze",
    "silver",
    "gold",
    "temp",
    "blob-inventory",
    "archive",
  ])

  name                  = each.key
  storage_account_id    = azurerm_storage_account.data_lake.id
  container_access_type = "private"
}
