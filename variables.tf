########################################################################################################################
# Input Variables
########################################################################################################################

#
# Developer tips:
#   - Below are some common module input variables
#   - They should be updated for input variables applicable to the module being added
#   - Use variable validation when possible
#

variable "name" {
  type        = string
  description = "Name of the dedicated host and dedicated host group"
}

variable "resource_group_id" {
  type        = string
  description = "The ID of the resource group where you want to create the service."
}

variable "resource_tags" {
  type        = list(string)
  description = "List of resource tag to associate with the instance."
  default     = []
}

variable "zone" {
  description = "Zone where the instance will be created"
  type        = string
}

variable "family" {
  description = "Family defines the purpose of the dedicated host, The dedicated host family can be defined from balanced,compute or memory. Refer [Understanding DH Profile family](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui#:~:text=%22b%22%3A%20balanced%20family,1%3A28%20ratio) for more details"
  type        = string
  default     = "balanced"
}

variable "class" {
  description = "Profile class of the dedicated host, this has to be defined based on the VSI usage. Refer [Understanding DH Class](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui#:~:text=common%20use%20cases.-,Understanding%20profiles,-The%20following%20example) for more details"
  default     = "bx2"
}

variable "profile" {
  description = "Profile for the dedicated hosts(size and resources). Refer [Understanding DH Profile](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui) for more details"
  type        = string
  default     = "bx2-host-152x608"
}

