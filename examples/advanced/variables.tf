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

variable "dedicated_host_group" {
  type = string
  description = "Name of the existing dedicated host group, the dedicated host will be created on the give host group. If none given, a new dedicated host group will be created. "
  default = null
}

variable "dedicated_host_count" {
  description = "Number of dedicated hosts that has to be created."
  type        = number
  default     = 1
}

variable "zone" {
  description = "Zone where the instance will be created"
  type        = string
}

variable "family" {
  description = "The family determines the intended purpose and workload optimization of the dedicated host group. The dedicated host group family can be defined from balanced,compute or memory. Refer [Understanding DH Profile family](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui) for more details"
  type        = string
  validation {
    condition     = contains(["balanced", "compute", "memory"], var.family)
    error_message = "The 'family' variable must be one of the following values: 'balanced', 'compute', or 'memory'."
  }
  default = "balanced"
}  

variable "class" {
  description = "The class determines the virtual server instance (VSI) usage and the workload type the dedicated host group is optimized for. Refer [Understanding DH Class](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui#dh-profiles-naming-rule) for more details"
  default     = "bx2"
}

variable "profile" {
  description = "Profile for the dedicated hosts(size and resources). Refer [Understanding DH Profile](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui) for more details"
  type        = string
  default     = "bx2-host-152x608"
}

########################################################################################################################
# VSI Input Variables
########################################################################################################################

variable "access_tags" {
  type        = list(string)
  description = "A list of access tags to apply to the VSI resources created by the module."
  default     = []
}

variable "image_id" {
  description = "Image ID used for VSI. Run 'ibmcloud is images' to find available images. Be aware that region is important for the image since the id's are different in each region."
  type        = string
  default     = "r006-ec03e14e-6336-4fe6-ba4f-460e266c6b10"
}

variable "machine_type" {
  description = "VSI machine type"
  type        = string
  default     = "cx2-2x4"
}

variable "create_security_group" {
  description = "Create security group for VSI"
  type        = string
  default     = false
}

variable "security_group" {
  description = "Security group created for VSI"
  type = object({
    name = string
    rules = list(
      object({
        name      = string
        direction = string
        source    = string
        tcp = optional(
          object({
            port_max = number
            port_min = number
          })
        )
        udp = optional(
          object({
            port_max = number
            port_min = number
          })
        )
        icmp = optional(
          object({
            type = number
            code = number
          })
        )
      })
    )
  })
  default = null
}

variable "user_data" {
  description = "User data to initialize VSI deployment"
  type        = string
  default     = null
}

variable "boot_volume_encryption_key" {
  description = "CRN of boot volume encryption key"
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
