########################################################################################################################
# Outputs for Dedicated Hosts and Dedicated Host groups
########################################################################################################################

output "dedicated_host_id" {
  value = ibm_is_dedicated_host.dh_host.id
}

output "dedicated_host_group_id" {
  value = ibm_is_dedicated_host_group.dh_group.id
}
