########################################################################################################################
# Outputs for Dedicated Hosts and Dedicated Host groups
########################################################################################################################

# Output for all dedicated host group IDs
output "dedicated_host_group_ids" {
  value = {for item in local.flattened_hosts : item.key => item.host_group_id}
}

# Output for all dedicated host IDs
output "dedicated_host_ids"  {
  value = [for host in ibm_is_dedicated_host.dh_host : host.id]
}
