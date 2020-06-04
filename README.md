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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| location | Location | `string` | n/a | yes |
| resource\_group\_name | Name of resource group | `string` | n/a | yes |
| ssh\_key\_data | SSH key | `string` | n/a | yes |
| subnet\_id | Subnet ID in which to deploy VM | `string` | n/a | yes |
| vm\_size | Size of machine on which to deploy Tamr | `string` | n/a | yes |
| admin\_username | Admin username | `string` | `"ubuntu"` | no |
| application\_security\_group\_ids | List of Application security group IDs | `list(string)` | `[]` | no |
| auth\_port | Port hosting Auth access | `number` | `9020` | no |
| disk\_size\_gb | Disk size | `number` | `1000` | no |
| elasticsearch\_port | Port hosting Elasticsearch access | `number` | `9200` | no |
| enable\_auth\_port | Whether or not to enable Auth | `bool` | `true` | no |
| enable\_elasticsearch\_port | Whether or not to enable Elasticsearch | `bool` | `true` | no |
| enable\_grafana\_port | Whether or not to enable Grafana | `bool` | `true` | no |
| enable\_kibana\_port | Whether or not to enable Kibana | `bool` | `true` | no |
| enable\_persistence\_port | Whether or not to enable Persistence | `bool` | `true` | no |
| enable\_ssh | Whether or not to enable SSH | `bool` | `true` | no |
| enable\_tls | Whether or not to enable TLS | `bool` | `true` | no |
| enable\_zk\_port | Whether or not to enable Zookeeper | `bool` | `true` | no |
| grafana\_port | Port hosting Grafana access | `number` | `31101` | no |
| image\_reference | Base image for VM | `string` | `null` | no |
| ingress\_cidr\_blocks | CIDR blocks to attach to security groups for ingress | `list(string)` | `[]` | no |
| kibana\_port | Port hosting Kibana access | `number` | `5601` | no |
| managed\_disk\_type | Managed disk type | `string` | `"Premium_LRS"` | no |
| persistence\_port | Port hosting Persistence access | `number` | `9080` | no |
| public\_ip | n/a | `string` | `null` | no |
| tags | Map of tags to attach to VM and Network Interface | `map(string)` | `{}` | no |
| tamr\_port | Port hosting Tamr UI and API access | `number` | `9100` | no |
| vm\_name | Name of VM on which Tamr is installed | `string` | `"tamr-vm"` | no |
| zk\_port | Port hosting Zookeeper access | `number` | `21281` | no |

## Outputs

| Name | Description |
|------|-------------|
| nic\_id | The ID of the Network Interface |
| sg\_id | The ID of the security group |
| vm\_id | The ID of the Tamr VM |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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
