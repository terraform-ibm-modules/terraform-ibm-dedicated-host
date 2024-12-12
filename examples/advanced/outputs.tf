##############################################################################
# Outputs
##############################################################################

output "resource_group_name" {
  description = "Resource group name."
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "Resource group ID."
  value       = module.resource_group.resource_group_id
}

output "dedicated_host_id" {
  value = ibm_is_dedicated_host.dh_host.id
}

output "dedicated_host_group_id" {
  value = ibm_is_dedicated_host_group.dh_group.id
}