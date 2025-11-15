<!-- Update this title with a descriptive name. Use sentence case. -->
# IBM Dedicated Host Module

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-module-template?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)


This module used to provision dedicated Host which is a fully dedicated, single-tenant physical server hosted in IBM Cloud data centers. It is designed for enterprises that require strict isolation of workloads, enhanced security, and consistent performance. With a dedicated host, customers have full control over server allocation, resource usage, and compliance requirements while leveraging the scalability and reliability of the IBM Cloud.

<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-dedicated-host](#terraform-ibm-dedicated-host)
* [Examples](./examples)
    * <div style="display: inline-block;"><a href="./examples/advanced">Advanced example</a></div> <div style="display: inline-block; vertical-align: middle;"><a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dh-advanced-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/advanced" target="_blank"><img src="https://cloud.ibm.com/media/docs/images/icons/Deploy_to_cloud.svg" alt="Deploy to IBM Cloud button"></a></div>
    * <div style="display: inline-block;"><a href="./examples/basic">Basic example</a></div> <div style="display: inline-block; vertical-align: middle;"><a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dh-basic-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/basic" target="_blank"><img src="https://cloud.ibm.com/media/docs/images/icons/Deploy_to_cloud.svg" alt="Deploy to IBM Cloud button"></a></div>
    * <div style="display: inline-block;"><a href="./examples/upgrade">Upgraded example</a></div> <div style="display: inline-block; vertical-align: middle;"><a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dh-upgrade-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/upgrade" target="_blank"><img src="https://cloud.ibm.com/media/docs/images/icons/Deploy_to_cloud.svg" alt="Deploy to IBM Cloud button"></a></div>
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-dedicated-host

### Usage

```hcl
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.71.2, < 2.0.0"
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

module "dedicated_host" {
  source            = "terraform-ibm-modules/dedicated-host/ibm"
  version           = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  prefix = "dhtest"
  dedicated_hosts = [
    {
      host_group_name     = "${var.prefix}-dhgroup"
      existing_host_group = false
      resource_group_id   = module.resource_group.resource_group_id
      class               = "bx2"
      family              = "balanced"
      zone                = "${var.region}-1"
      resource_tags       = var.resource_tags
      dedicated_host = [
        {
          name    = "${var.prefix}-dhhost"
          profile = "bx2-host-152x608"
        }
      ]
    }
  ]
}
```

### Required IAM access policies

You need the following permissions to run this module.

- Account Management
    - **Resource Group** service
        - `Viewer` platform access
- IAM Services
    - **IBM Cloud Activity Tracker** service
        - `Editor` platform access
        - `Manager` service access
    - **IBM Cloud Monitoring** service
        - `Editor` platform access
        - `Manager` service access
    - **IBM Cloud Object Storage** service
        - `Editor` platform access
        - `Manager` service access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |

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
| <a name="input_dedicated_hosts"></a> [dedicated\_hosts](#input\_dedicated\_hosts) | A list of objects which contain the required inputs for the dedicated host and dedicated host groups, a flag indicating the user to use an existing host group by enabling it. Also has the default values for a dedicated host setup which are recommended by IBM Cloud. | <pre>list(object({<br/>    host_group_name     = string<br/>    existing_host_group = optional(bool, false)<br/>    resource_group_id   = string<br/>    class               = optional(string, "bx2")<br/>    family              = optional(string, "balanced")<br/>    zone                = optional(string, "us-south-1")<br/>    dedicated_host = list(object({<br/>      name        = string<br/>      profile     = optional(string, "bx2-host-152x608")<br/>      access_tags = optional(list(string), [])<br/>    }))<br/>  }))</pre> | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_dedicated_host_group_ids"></a> [dedicated\_host\_group\_ids](#output\_dedicated\_host\_group\_ids) | List the Dedicated Host Group ID's |
| <a name="output_dedicated_host_ids"></a> [dedicated\_host\_ids](#output\_dedicated\_host\_ids) | List the Dedicated Host ID's |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set-up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
