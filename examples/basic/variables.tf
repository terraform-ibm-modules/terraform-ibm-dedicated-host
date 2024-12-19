########################################################################################################################
# Dedicated Host Input Variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key."
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region to provision all resources created by this example."
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group where you want to create the service."
}
