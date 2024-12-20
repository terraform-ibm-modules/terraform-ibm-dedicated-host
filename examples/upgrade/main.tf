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
# Upgraded Example for Dedicated Host Module
########################################################################################################################

module "dedicated_host" {
  source = "../.."
  dedicated_hosts = [
    {
      host_group_name     = "${var.prefix}-dhgroup"
      existing_host_group = false
      resource_group_id   = module.resource_group.resource_group_id
      class               = "bx2"
      family              = "balanced"
      zone                = "${var.region}-1"
      dedicated_host = [
        {
          name    = "${var.prefix}-dhhost"
          profile = "bx2-host-152x608"
        }
      ]
    }
  ]
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
  name       = "${var.prefix}-ssh-key"
  public_key = resource.tls_private_key.tls_key[0].public_key_openssh
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
  source                = "terraform-ibm-modules/landing-zone-vsi/ibm"
  version               = "4.4.0"
  resource_group_id     = module.resource_group.resource_group_id
  image_id              = var.image_ids[var.region]
  create_security_group = false
  tags                  = var.resource_tags
  access_tags           = var.access_tags
  subnets               = module.slz_vpc.subnet_zone_list
  vpc_id                = module.slz_vpc.vpc_id
  prefix                = var.prefix
  placement_group_id    = ibm_is_placement_group.placement_group.id
  #  dedicated_host_id          = module.dedicated_host.dedicated_host_group_ids
  machine_type   = "cx2-2x4"
  user_data      = var.user_data
  vsi_per_subnet = var.vsi_per_subnet
  ssh_key_ids    = [ibm_is_ssh_key.ssh_key.id]
}