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
locals {
  image_ids = {
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


module "slz_vsi" {
  source                = "terraform-ibm-modules/landing-zone-vsi/ibm"
  version               = "4.4.0"
  resource_group_id     = module.resource_group.resource_group_id
  image_id              = var.image_id != null ? var.image_id : local.image_ids[var.region]
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
