################################################################
##   Data module for existing Dedicated Group                 ##
################################################################

data "ibm_is_dedicated_host_group" "existing_dh_group" {
  count = var.dedicated_host_group != null ? 1 : 0
  name  = var.dedicated_host_group
}

################################################################

################################################################
##   Root Module for Dedicated host and Dedicated Host Group  ##
################################################################

resource "ibm_is_dedicated_host_group" "dh_group" {
  count          = var.dedicated_host_group == null ? 1 : 0
  name           = "${var.prefix}"
  class          = var.class
  family         = var.family
  zone           = var.zone
  resource_group = var.resource_group_id
}

################################################################

resource "ibm_is_dedicated_host" "dh_host" {
  count          = var.dedicated_host_count
  name           = "${var.prefix}-${count.index}"
  profile        = var.profile
  host_group     = var.dedicated_host_group != null ? data.ibm_is_dedicated_host_group.existing_dh_group[0].id : ibm_is_dedicated_host_group.dh_group[0].id
  resource_group = var.resource_group_id
  access_tags    = var.resource_tags
}
