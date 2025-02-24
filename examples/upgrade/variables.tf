########################################################################################################################
# Input Variables
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

########################################################################################################################
# Dedicated Host Input Variables
########################################################################################################################

variable "resource_group" {
  type        = string
  description = "The name of the resource group where you want to create the service."
  default     = null
}

########################################################################################################################
# VSI Input Variables
########################################################################################################################

variable "prefix" {
  type        = string
  description = "Name of the VSI resources"
}

variable "resource_tags" {
  type        = list(string)
  description = "A list of access tags to apply to the VSI resources created by the module."
  default     = []
}

variable "access_tags" {
  type        = list(string)
  description = "A list of access tags to apply to the VSI resources created by the module. For more information, see https://cloud.ibm.com/docs/account?topic=account-access-tags-tutorial."
  default     = []

  validation {
    condition = alltrue([
      for tag in var.access_tags : can(regex("[\\w\\-_\\.]+:[\\w\\-_\\.]+", tag)) && length(tag) <= 128
    ])
    error_message = "Tags must match the regular expression \"[\\w\\-_\\.]+:[\\w\\-_\\.]+\". For more information, see https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#limits."
  }
}

variable "user_data" {
  description = "User data to initialize VSI deployment"
  type        = string
  default     = null
}

variable "vsi_per_subnet" {
  description = "Number of VSI instances for each subnet"
  type        = number
  default     = 1
}

variable "ssh_key" {
  type        = string
  description = "An existing ssh key name to use for this example, if unset a new ssh key will be created"
  default     = null
}

variable "vpc_name" {
  type        = string
  description = "Name for VPC"
  default     = "vpc"
}
