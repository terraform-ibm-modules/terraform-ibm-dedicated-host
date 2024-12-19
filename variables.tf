########################################################################################################################
# Dedicated Host Input Variables
########################################################################################################################

variable "dedicated_hosts_group" {
  type = list(object({
    host_group_name     = string
    existing_host_group = optional(bool, false)
    resource_group_id   = string
    class               = optional(string, "bx2")
    family              = optional(string, "balanced")
    zone                = optional(string, "us-south-1")
    dedicated_hosts = list(object({
      name        = string
      profile     = optional(string, "bx2-host-152x608")
      access_tags = optional(list(string), [])
    }))
  }))
  description = "A list of objects which contain the required inputs for the dedicated host and dedicated host groups, a flag indicating the user to use an existing host group by enabling it. Also has the default values for a dedicated host setup which are recommended by IBM Cloud."
  default     = []
}
