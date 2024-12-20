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

variable "image_ids" {
  description = "Map of image IDs for different regions for the image ibm-ubuntu-24-04-6-minimal-amd64-2"
  type        = map(string)
  default = {
    us-east  = "r014-1696a049-e959-493d-9a97-1655ef4c942e"
    eu-de    = "r010-ee64bf0a-4596-47d3-bd58-2bdc71f3daee"
    ap-north = "r006-ac03e14e-5678-4fe6-ba4f-460e266c6e12"
    us-south = "r006-d734b459-b5a0-4777-8600-9fa3254d2cea"
    eu-gb    = "r018-941eb02e-ceb9-44c8-895b-b31d241f43b5"
    eu-es    = "r050-68aeeb7a-d78d-4a8f-aeba-e2843c98ff3a"
    jp-osa   = "r034-3d3ff9f4-9268-4496-a9e5-fb639c7dbcf3"
    br-sao   = "r042-39fe2404-4de3-4437-a176-5a63833ae4c1"
    au-syd   = "r026-92503c7e-388c-48cc-bf86-677b7b808583"
    jp-tok   = "r022-49d51ccb-6f70-438d-a31a-63fd961690bd"
    ca-tor   = "r038-7b030074-925d-43cf-aecd-6ef97883787e"
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
