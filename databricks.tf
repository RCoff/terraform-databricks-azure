resource "azurerm_databricks_workspace" "primary" {
  name                              = "dbw-${local.env}-${var.location_abbreviation}-databricks-01"
  location                          = azurerm_resource_group.databricks.location
  resource_group_name               = azurerm_resource_group.databricks.name
  sku                               = "premium"
  managed_resource_group_name       = "rg-${local.env}-${var.location_abbreviation}-managed_databricks-01"
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = true
  default_storage_firewall_enabled  = true
  access_connector_id               = azurerm_databricks_access_connector.workspace-storage.id

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.spoke-databricks.id
    private_subnet_name                                  = azurerm_subnet.databricks-private-01.name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks-private.id
    public_subnet_name                                   = azurerm_subnet.databricks-public-01.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.databricks-public.id
    storage_account_sku_name                             = "Standard_ZRS"
  }
}

resource "azurerm_databricks_access_connector" "workspace-storage" {
  name                = "dbac-${local.env}-${var.location_abbreviation}-workspace_storage-01"
  location            = azurerm_resource_group.databricks.location
  resource_group_name = azurerm_resource_group.databricks.name

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_databricks_access_connector" "data_lake" {
  name                = "dbac-${local.env}-${var.location_abbreviation}-data_lake-01"
  location            = azurerm_resource_group.data_infra.location
  resource_group_name = azurerm_resource_group.data_infra.name

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_monitor_diagnostic_setting" "databricks_audit" {
  name                       = "databricks-audit-logs"
  target_resource_id         = azurerm_databricks_workspace.primary.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
