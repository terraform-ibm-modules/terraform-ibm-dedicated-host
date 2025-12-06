########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.1"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Basic Example for Dedicated Host Module
########################################################################################################################

module "dedicated_host" {
  source = "../.."
  dedicated_hosts = [
    {
      host_group_name     = "${var.prefix}-dhgroup-1"
      existing_host_group = false
      resource_group_id   = module.resource_group.resource_group_id
      class               = "bx2"
      family              = "balanced"
      zone                = "${var.region}-1"
      resource_tags       = var.resource_tags
      dedicated_host = [
        {
          name    = "${var.prefix}-dhhost-1"
          profile = "bx2-host-152x608"
        },
        {
          name    = "${var.prefix}-dhhost-2"
          profile = "bx2-host-152x608"
        }
      ]
    }
  ]
}
