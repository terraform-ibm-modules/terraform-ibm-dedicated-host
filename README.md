<!-- Update this title with a descriptive name. Use sentence case. -->
# IBM Dedicated Host Module

<!--
Update status and "latest release" badges:
  1. For the status options, see https://terraform-ibm-modules.github.io/documentation/#/badge-status
  2. Update the "latest release" badge to point to the correct module's repo. Replace "terraform-ibm-module-template" in two places.
-->
[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-module-template?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-module-template/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!--
Add a description of modules in this repo.
Expand on the repo short description in the .github/settings.yml file.

For information, see "Module names and descriptions" at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=module-names-and-descriptions
-->

The dedicated host module provisions dedicated host for creating multiple VSI's on a single host


<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-dedicated-host](#terraform-ibm-dedicated-host)
* [Examples](./examples)
    * [Advanced example](./examples/advanced)
    * [Basic example](./examples/basic)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


<!--
If this repo contains any reference architectures, uncomment the heading below and link to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->
<!-- ## Reference architectures -->


<!-- Replace this heading with the name of the root level module (the repo name) -->
## terraform-ibm-dedicated-host

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.65.0, < 2.0.0"
    }
  }
}

locals {
    region = "us-south"
}

provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX"  # replace with apikey value
  region           = local.region
}

module "module_template" {
  source            = "terraform-ibm-modules/dedicated-host/ibm"
  version           = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  prefix = "basic-dhtest"
  dedicated_hosts_group = [
    {
      resource_group_id = "a8cff104f1764e98aac9ab879198230a" # pragma: allowlist secret
      class             = "bx2"
      family            = "balanced"
      zone              = "us-south-1"
      dedicated_hosts = [
        {
          profile     = "bx2-host-152x608"
          access_tags = ["env:test"]
        }
      ]
    }
  ]
}
```

### Required access policies

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the 'Sample IBM Cloud' service and roles with applicable values.
The required information can usually be found in the services official
IBM Cloud documentation.
To view all available service permissions, you can go in the
console at Manage > Access (IAM) > Access groups and click into an existing group
(or create a new one) and in the 'Access' tab click 'Assign access'.
-->

<!--
You need the following permissions to run this module:

- Service
    - **Resource group only**
        - `Viewer` access on the specific resource group
    - **Sample IBM Cloud** service
        - `Editor` platform access
        - `Manager` service access
-->

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->


<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.65.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_is_dedicated_host.dh_host](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_dedicated_host) | resource |
| [ibm_is_dedicated_host_group.dh_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_dedicated_host_group) | resource |
| [ibm_is_dedicated_host_group.existing_dh_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_dedicated_host_group) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dedicated_hosts_group"></a> [dedicated\_hosts\_group](#input\_dedicated\_hosts\_group) | n/a | <pre>list(object({<br/>    host_group_name   = optional(string, null)<br/>    resource_group_id = string<br/>    class             = optional(string, "bx2")<br/>    family            = optional(string, "balanced")<br/>    zone              = optional(string, "us-south-1")<br/>    dedicated_hosts = list(object({<br/>      profile     = optional(string, "bx2-host-152x608")<br/>      access_tags = optional(list(string), [])<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for the dedicated host resources. | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_dedicated_host_group_ids"></a> [dedicated\_host\_group\_ids](#output\_dedicated\_host\_group\_ids) | Output for all dedicated host group IDs |
| <a name="output_dedicated_host_ids"></a> [dedicated\_host\_ids](#output\_dedicated\_host\_ids) | Output for all dedicated host IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set-up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
