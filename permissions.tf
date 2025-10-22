resource "azurerm_role_assignment" "dbac--to--data_lake-storage_blob_contributor" {
  scope                = azurerm_storage_account.data_lake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.data_lake.identity[0].principal_id
}
