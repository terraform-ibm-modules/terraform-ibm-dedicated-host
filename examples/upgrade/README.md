# Upgraded example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=dedicated-host-upgrade-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-dedicated-host/tree/main/examples/upgrade">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
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
