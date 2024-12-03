########################################################################################################################
# Outputs
########################################################################################################################

#
# Developer tips:
#   - Below are some good practise sample outputs
#   - They should be updated for outputs applicable to the module being added
#   - Use variable validation when possible
#

output "dedicated_host_id" {
  value = ibm_is_dedicated_host.test_dh.id
}

output "dedicate_host_group_id" {
  value = ibm_is_dedicated_host_group.test_dh.id
}
