################################################################
##   Root Module for Dedicated Host Group                     ##
################################################################

# Dedicated Host Group
resource "ibm_is_dedicated_host_group" "dh_group" {
  for_each = {
    for obj, group in var.dedicated_hosts_group : obj => group
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
    for group_obj, group in var.dedicated_hosts_group :
    group_obj => group
    if group.existing_host_group == true
  }

  name = each.value.host_group_name
}

locals {
  flattened_hosts = flatten([
    for group_obj, group in var.dedicated_hosts_group : [
      for host_obj, host in group.dedicated_hosts : {
        key               = "${group_obj}-${host_obj}"
        name              = host.name
        profile           = host.profile
        host_group_id     = group.existing_host_group ? data.ibm_is_dedicated_host_group.existing_dh_group[group_obj].id : ibm_is_dedicated_host_group.dh_group[group_obj].id
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
  for_each = { for item in local.flattened_hosts : item.key => item }

  name           = each.value.name
  profile        = each.value.profile
  host_group     = each.value.host_group_id
  resource_group = each.value.resource_group_id
  access_tags    = each.value.access_tags
}

################################################################
