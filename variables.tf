########################################################################################################################
# Dedicated Host Input Variables
########################################################################################################################

variable "prefix" {
  type        = string
  description = "Prefix for the dedicated host resources."
}

variable "dedicated_hosts_group" {
  type = list(object({
    host_group_name   = optional(string, null)
    resource_group_id = string
    class             = optional(string, "bx2")
    family            = optional(string, "balanced")
    zone              = optional(string, "us-south-1")
    dedicated_hosts = list(object({
      profile     = optional(string, "bx2-host-152x608")
      access_tags = optional(list(string), [])
    }))
  }))
}
