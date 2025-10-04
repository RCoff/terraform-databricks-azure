locals {
  # Take the first letter of the "environment" variable to use as a prefix in resource names
  env = substr(var.environment, 0, 1)

  # Resource tagging is imperative for cost management and resource organization.
  commons_tags = {
    Environment = var.environment
  }
  networking_tags = merge(local.commons_tags, {
    Owner      = "Networking Team"
    CostCenter = "00000"
  })
  data_infra_tags = merge(local.commons_tags, {
    Owner      = "Data Infra Team"
    CostCenter = "00001"
  })
  databricks_tags = merge(local.commons_tags, {
    Owner      = "Analytics Team"
    CostCenter = "00002"
  })
}
