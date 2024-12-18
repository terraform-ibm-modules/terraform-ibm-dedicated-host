########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Basic Example for Dedicated Host Module
########################################################################################################################

module "dedicated_host" {
  source = "../.."
  prefix            = "basic-dhtest"
  dedicated_hosts_group = [
    {
      resource_group_id = "0808a9d6f8874342b7c4c07ad1666dc2"
      class             = "bx2"
      family            = "balanced"
      zone              = "us-south-1"
      dedicated_hosts = [
        {
          profile     = "bx2-host-152x608"
          access_tags = ["env:test"]
        }
      ]
    }
  ]
}

##############################################################################
# Locals
##############################################################################

locals {
  ssh_key_id = var.ssh_key != null ? data.ibm_is_ssh_key.existing_ssh_key[0].id : resource.ibm_is_ssh_key.ssh_key[0].id
}

##############################################################################
# Create new SSH key
##############################################################################

resource "tls_private_key" "tls_key" {
  count     = var.ssh_key != null ? 0 : 1
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "ibm_is_ssh_key" "ssh_key" {
  count      = var.ssh_key != null ? 0 : 1
  name       = "${var.prefix}-ssh-key"
  public_key = resource.tls_private_key.tls_key[0].public_key_openssh
}

data "ibm_is_ssh_key" "existing_ssh_key" {
  count = var.ssh_key != null ? 1 : 0
  name  = var.ssh_key
}

#############################################################################
# Provision VPC
#############################################################################

module "slz_vpc" {
  source            = "terraform-ibm-modules/landing-zone-vpc/ibm"
  version           = "7.19.1"
  resource_group_id = module.resource_group.resource_group_id
  region            = var.region
  prefix            = var.prefix
  tags              = var.resource_tags
  name              = var.vpc_name
}

#############################################################################
# Placement group
#############################################################################

resource "ibm_is_placement_group" "placement_group" {
  name           = "${var.prefix}-host-spread"
  resource_group = module.resource_group.resource_group_id
  strategy       = "host_spread"
  tags           = var.resource_tags
}

#############################################################################
# Provision VSI
#############################################################################

module "slz_vsi" {
  source                     = "terraform-ibm-modules/landing-zone-vsi/ibm"
  version                    = "4.4.0"
  resource_group_id          = module.resource_group.resource_group_id
  image_id                   = var.image_id
  create_security_group      = var.create_security_group
  security_group             = var.security_group
  tags                       = var.resource_tags
  access_tags                = var.access_tags
  subnets                    = module.slz_vpc.subnet_zone_list
  vpc_id                     = module.slz_vpc.vpc_id
  prefix                     = var.prefix
  placement_group_id         = ibm_is_placement_group.placement_group.id
#  dedicated_host_id          = module.dedicated_host.dedicated_host_group_ids
  machine_type               = var.machine_type
  user_data                  = var.user_data
  boot_volume_encryption_key = var.boot_volume_encryption_key
  vsi_per_subnet             = var.vsi_per_subnet
  ssh_key_ids                = [local.ssh_key_id]
}
