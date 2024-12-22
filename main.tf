################################################################
##   Root Module for Dedicated Host Group                     ##
################################################################

locals {
  all_dh_groups = {
    for group in var.dedicated_hosts :
    "${group.host_group_name}-${group.zone}" => {
      host_group_name     = group.host_group_name
      existing_host_group = group.existing_host_group
      resource_group_id   = group.resource_group_id
      class               = group.class
      family              = group.family
      zone                = group.zone
    }
  }
}


# Dedicated Host Group
resource "ibm_is_dedicated_host_group" "dh_group" {
  for_each = {
    for key, group in local.all_dh_groups :
    key => group
    if group.existing_host_group == false
  }

  name           = each.value.host_group_name
  class          = each.value.class
  family         = each.value.family
  zone           = each.value.zone
  resource_group = each.value.resource_group_id
}

################################################################

################################################################
##   Data Block for finding Existing Dedicated Host Group     ##
################################################################

data "ibm_is_dedicated_host_group" "existing_dh_group" {
  for_each = {
    for key, group in local.all_dh_groups :
    key => group
    if group.existing_host_group == true
  }

  name = each.value.host_group_name
}

################################################################

################################################################
##   Local Flattened Hosts                                    ##
################################################################

locals {
  flattened_hosts = flatten([
    for group in var.dedicated_hosts : [
      for host in group.dedicated_host : {
        key               = group.host_group_name
        name              = host.name
        profile           = host.profile
        host_group_id     = group.existing_host_group ? data.ibm_is_dedicated_host_group.existing_dh_group["${group.host_group_name}-${group.zone}"].id : ibm_is_dedicated_host_group.dh_group["${group.host_group_name}-${group.zone}"].id
        resource_group_id = group.resource_group_id
        access_tags       = host.access_tags
      }
    ]
  ])
}

################################################################

################################################################
##           Root Module for Dedicated Host                   ##
################################################################

resource "ibm_is_dedicated_host" "dh_host" {
  for_each = { for item in local.flattened_hosts : item.name => item }

  name           = each.value.name
  profile        = each.value.profile
  host_group     = each.value.host_group_id
  resource_group = each.value.resource_group_id
  access_tags    = each.value.access_tags
}

################################################################
