# Advanced example

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.65.0, < 2.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dedicated_host"></a> [dedicated\_host](#module\_dedicated\_host) | ../.. | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.6 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_class"></a> [class](#input\_class) | Profile class of the dedicated host, this has to be defined based on the VSI usage. Refer [Understanding DH Class](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui#:~:text=common%20use%20cases.-,Understanding%20profiles,-The%20following%20example) for more details | `string` | `"bx2"` | no |
| <a name="input_family"></a> [family](#input\_family) | Family defines the purpose of the dedicated host, The dedicated host family can be defined from balanced,compute or memory. Refer [Understanding DH Profile family](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui#:~:text=%22b%22%3A%20balanced%20family,1%3A28%20ratio) for more details | `string` | `"balanced"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | The IBM Cloud API Key. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the dedicated host and dedicated host group | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | Profile for the dedicated hosts(size and resources). Refer [Understanding DH Profile](https://cloud.ibm.com/docs/vpc?topic=vpc-dh-profiles&interface=ui) for more details | `string` | `"bx2-host-152x608"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to provision all resources created by this example. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group where you want to create the service. | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | List of resource tag to associate with the instance. | `list(string)` | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone where the instance will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dedicated_host_group_id"></a> [dedicated\_host\_group\_id](#output\_dedicated\_host\_group\_id) | n/a |
| <a name="output_dedicated_host_id"></a> [dedicated\_host\_id](#output\_dedicated\_host\_id) | n/a |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | Resource group ID. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name. |