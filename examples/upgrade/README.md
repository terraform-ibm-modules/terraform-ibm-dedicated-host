# Upgraded example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dedicated-host-upgrade-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/upgrade"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


### Provisioning a Dedicated Host Group:
- Creates a dedicated host group if existing_host_group is false.
- Option to use an existing host group by setting existing_host_group to true.

### Creating a Dedicated Host:

- Provisions a dedicated host within the specified or newly created host group.

### Virtual Server Instance (VSI) Creation:

- Deploys a VSI on the provisioned dedicated host, ensuring full utilization of the dedicated environment.
- VSI configuration includes options like image_id, zone, and profile.

### Dynamic Resource Mapping:

- Automatically maps the VSI to the dedicated host ID created in the process.

### Outputs for Resource Tracking:

- Provides IDs for the dedicated host group, dedicated host, and VSI for easy reference.

### Flexible Inputs:

- Allows defining configurations for both the dedicated host and the VSI under the same infrastructure setup.

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
