################################################################
##   Root Module for Dedicated host and Dedicated Group       ##
################################################################

resource "ibm_is_dedicated_host_group" "dh_group" {
  name           = "${var.name}-dhgrp"
  class          = var.class
  family         = var.family
  zone           = var.zone
  resource_group = var.resource_group_id
}

resource "ibm_is_dedicated_host" "dh_host" {
  name           = "${var.name}-dh"
  profile        = var.profile
  host_group     = ibm_is_dedicated_host_group.dh_group.id
  resource_group = var.resource_group_id
}