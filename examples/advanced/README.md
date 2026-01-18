# Advanced example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dedicated-host-advanced-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/advanced"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


## Create a single Dedicated Host and a Dedicated Host Group

### Provision a New Dedicated Host Group:
- Creates a new dedicated host group with specified attributes (e.g., host_group_name, class, family, zone).

### Dedicated Host Creation:
- Provisions a single dedicated host within the newly created host group.

## Create second Dedicated Hosts on the Above Host Group

###   Reusing the Created Host Group:
- The host group created in Scenario 1 is reused for additional hosts.

###   Provision Second Dedicated Hosts:
- Adds two new dedicated hosts to the existing host group, each with its own name and profile.

### Dynamic Resource Mapping:
- Automatically links dedicated hosts to their respective host group IDs.

### Flexible Inputs:
- Configurable inputs to define host groups and dedicated hosts for each scenario.

### Outputs for Resource Management:
- Provides IDs for the dedicated host group and all provisioned hosts.

### Scalable Architecture:
- Easily extendable to support additional hosts or scenarios.

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
