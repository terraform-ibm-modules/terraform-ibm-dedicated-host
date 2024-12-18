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

variable "prefix" {
  type        = string
  description = "Name of the dedicated host resources"
  default     = "dh-test"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group where you want to create the service."
}

variable "resource_tags" {
  type = list(string)
  validation {
    condition     = alltrue([for tag in var.resource_tags : can(regex("^[^:]+:[^:]+$", tag))])
    error_message = "Each access tag must be in the format 'key:value', where both 'key' and 'value' are non-empty strings."
  }
  default = ["env:test"]
}

variable "zone" {
  description = "Zone where the instance will be created"
  type        = string
}
