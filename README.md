# Tamr Azure VM module

This module creates an Azure VM to host the Tamr application and its
internal microservices.

# Examples
TO BE UPDATED
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "minimal" {
  source = "git::https://github.com/Datatamer/terraform-template-repo?ref=0.1.0"
}
```
## Minimal
Smallest complete fully working example. This example might require extra resources to run the example.
- [Minimal](https://github.com/Datatamer/terraform-template-repo/tree/master/examples/minimal)

# Resources Created
This modules creates:
* 1 network interface
* 1 VM

# Variables 
## Inputs
Write your Terraform module inputs.
* `resource_group_name`: (required) Name of resource group
* `location`: (required) Location
* `machine_type`: (required) Type of machine on which to deploy Tamr
* `vnet_id`: (required) Virtual network in which to deploy VM
* `subnet_id`: (required) Subnet in which to deploy VM
* `existing_network_resource_group`: (rquired) Resource group which owns the VNet
* `vm_name`: (optional) Name of VM on which Tamr is installed
* `ssh_key_data`: (required) SSH key
* `managed_disk_type`: (optional) Managed disk type
* `disk_size_gb`: (optional) Disk size
* `image_reference`: (optional) Base image for VM
* `admin_username`: (optional) Admin username
* `network_sec_gr_id`: (optional) Network security group id
* `public_ip`: (optional) Public ip

## Outputs
No output variables.

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
