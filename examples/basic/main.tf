########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.name}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Dedicated Host
########################################################################################################################

module "dedicated_host" {
  source            = "../.."
  name              = var.name
  class             = var.class
  family            = var.family
  zone              = var.zone
  resource_group_id = module.resource_group.resource_group_id
}
