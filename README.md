# Tamr Azure VM module

This module creates an Azure VM to host the Tamr application and its
internal microservices.

# Examples
TO BE UPDATED
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "minimal" {
  source = "git::https://github.com/Datatamer/terraform-azure-tamr-vm?ref=0.2.0"
}
```
## Minimal
Smallest complete fully working example. This example might require extra resources to run the example.
- [Minimal](https://github.com/Datatamer/terraform-azure-tamr-vm/tree/master/examples/minimal)

# Resources Created
This modules creates:
* 1 network interface
* 1 VM
* 1 storage disk
* 1 security group

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
* `public_ip`: (optional) Public ip
* `tamr_port`: (optional) Port hosting Tamr UI and API access
* `enable_kibana_port`: (optional) Whether or not to enable Kibana
* `kibana_port`: (optional) Port hosting Kibana access
* `enable_grafana_port`: (optional) Whether or not to enable Grafana
* `grafana_port`: (optional) Port hosting Grafana access
* `enable_elasticsearch_port`: (optional) Whether or not to enable Elasticsearch
* `elasticsearch_port`: (optional) Port hosting Elasticsearch access
* `enable_tls`: (optional) Whether or not to enable TLS
* `enable_ssh`: (optional) Whether or not to enable SSH
* `ingress_cidr_blocks`: (optional) CIDR blocks to attach to security groups for ingress
* `application_security_group_ids`: (Optional) List of Application security group IDs
* `tags`: (optional) Map of tags to attach to VM and Network Interface

## Outputs
* `vm_id`: ID of the Tamr VM
* `nic_id`: ID of the network interface
* `sg_id`: ID of the security group

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
