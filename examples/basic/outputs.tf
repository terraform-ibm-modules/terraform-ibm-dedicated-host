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
  value = module.dedicated_host.dedicated_host_id
}

output "dedicated_host_group_id" {
  value = module.dedicated_host.dedicated_host_group_id
}