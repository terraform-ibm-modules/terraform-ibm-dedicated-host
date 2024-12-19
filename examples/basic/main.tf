########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "dhbasic-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Basic Example for Dedicated Host Module
########################################################################################################################

module "dedicated_host" {
  source = "../.."
  dedicated_hosts_group = [
    {
      host_group_name     = "basic-dhgroup"
      existing_host_group = false
      resource_group_id   = "0808a9d6f8874342b7c4c07ad1666dc2"
      class               = "bx2"
      family              = "balanced"
      zone                = "us-south-1"
      dedicated_hosts = [
        {
          name    = "basic-dhhost"
          profile = "bx2-host-152x608"
        }
      ]
    }
  ]
}
