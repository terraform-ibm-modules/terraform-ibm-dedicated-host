################################################################
##   Root Module for Dedicated Host Group                     ##
################################################################

locals {
  flattened_group_hosts = flatten([
    for group in var.dedicated_hosts : [
      for host in group.dedicated_host : {
        groupname           = group.host_group_name
        existing_host_group = group.existing_host_group
        hostname            = host.name
        class               = group.class
        family              = group.family
        zone                = group.zone
        profile             = host.profile
        resource_group_id   = group.resource_group_id
      }
    ]
  ])
}

################################################################
####              Dedicated Host Group                      ####
################################################################

locals {
  # Ensure only new groups (existing_host_group = false) are used
  unique_dedicated_hosts = {
    for group in var.dedicated_hosts :
    group.host_group_name => group
    if group.existing_host_group == false
  }
}

resource "ibm_is_dedicated_host_group" "dh_group" {
  for_each = local.unique_dedicated_hosts

  name           = each.value.host_group_name
  class          = each.value.class
  family         = each.value.family
  zone           = each.value.zone
  resource_group = each.value.resource_group_id
}

################################################################
####        Data Block for existing Host Group              ####
################################################################
data "ibm_is_dedicated_host_group" "existing_dh_group" {
  for_each = {
    for item in local.flattened_group_hosts :
    item.groupname => item
    if item.existing_host_group == true
  }

  name = each.value.groupname
}

################################################################
# Flattened Hosts with Key Reference
################################################################
locals {
  flattened_hosts = flatten([
    for group in var.dedicated_hosts : [
      for host in group.dedicated_host : {
        key               = "${group.host_group_name}-${host.name}"
        name              = host.name
        profile           = host.profile
        host_group_id     = group.existing_host_group ? data.ibm_is_dedicated_host_group.existing_dh_group[group.host_group_name].id : ibm_is_dedicated_host_group.dh_group[group.host_group_name].id
        resource_group_id = group.resource_group_id
        access_tags       = host.access_tags
      }
    ]
  ])
}

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
