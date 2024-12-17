########################################################################################################################
# Outputs for Dedicated Hosts and Dedicated Host groups
########################################################################################################################

output "dedicated_host_id" {
  value = ibm_is_dedicated_host.dh_host[0].id
}

output "dedicated_host_group_id" {
  value = ibm_is_dedicated_host_group.dh_group[0].id
}
