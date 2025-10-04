variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
}

variable "location" {
  description = "The region to deploy resources in. Must be a valid Azure region."
  type        = string
}

variable "location_abbreviation" {
  description = "Abbreviation for the Azure region (e.g., 'eus' for East US). Used in resource naming."
  type        = string
}
