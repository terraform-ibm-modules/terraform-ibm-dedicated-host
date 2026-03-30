# Basic example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dedicated-host-basic-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/basic">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->

## Provision New or Use Existing Host Groups:

-  Creates a new host group if existing_host_group is false.
-  References an existing host group if existing_host_group is true.

## Dedicated Host Creation:

-  Provisions dedicated hosts within the specified host group, with customizable names and profiles.

## Dynamic Resource Mapping:

-  Automatically maps host group IDs for new or existing groups.

## Flexible Inputs:

-  Supports input for multiple host groups and their dedicated hosts.

## Outputs for Easy Reference:

-  Provides IDs for all created host groups and hosts.
