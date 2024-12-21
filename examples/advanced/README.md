# Advanced example

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
