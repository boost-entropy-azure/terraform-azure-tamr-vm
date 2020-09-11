# Tamr Azure VM module

This module creates an Azure VM to host the Tamr application and its
internal microservices.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "minimal" {
  source = "git::https://github.com/Datatamer/terraform-azure-tamr-vm?ref=0.3.4"
}
```
## Minimal
Smallest complete fully working example. This example might require extra resources to run the example.
- [Minimal](https://github.com/Datatamer/terraform-azure-tamr-vm/tree/master/examples/minimal)

## Elasticsearch
Example of multiple VM creation with all ports disabled except the port hosting Elasticsearch access.
- [Elasticsearch](https://github.com/Datatamer/terraform-azure-tamr-vm/tree/master/examples/elasticsearch)

# Resources Created
This modules creates:
* n network interfaces
* n VMs
* n storage disks
* 1 security group

# Known Issues
When running `terraform destroy`, you may encounter a failure due to something not having fully deleted. To resolve this, wait a few seconds and then re-run `terraform destroy`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_security\_group\_ids | List of Application security group IDs | `list(string)` | n/a | yes |
| location | Location | `string` | n/a | yes |
| path\_to\_ssh\_key | Local file path to a public SSH key | `string` | n/a | yes |
| resource\_group\_name | Name of resource group | `string` | n/a | yes |
| subnet\_id | Subnet ID in which to deploy VM | `string` | n/a | yes |
| vm\_size | Size of machine on which to deploy Tamr | `string` | n/a | yes |
| admin\_username | Admin username | `string` | `"ubuntu"` | no |
| auth\_port | Port hosting Auth access | `number` | `9020` | no |
| disk\_size\_gb | Disk size | `number` | `1000` | no |
| elasticsearch\_port | Port hosting Elasticsearch access | `number` | `9200` | no |
| enable\_auth\_port | Whether or not to enable Auth | `bool` | `true` | no |
| enable\_elasticsearch\_port | Whether or not to enable Elasticsearch | `bool` | `true` | no |
| enable\_grafana\_port | Whether or not to enable Grafana | `bool` | `true` | no |
| enable\_kibana\_port | Whether or not to enable Kibana | `bool` | `true` | no |
| enable\_persistence\_port | Whether or not to enable Persistence | `bool` | `true` | no |
| enable\_ssh | Whether or not to enable SSH | `bool` | `true` | no |
| enable\_tamr\_port | Whether or not to enable Tamr API access | `bool` | `true` | no |
| enable\_tls | Whether or not to enable TLS | `bool` | `true` | no |
| enable\_zk\_port | Whether or not to enable Zookeeper | `bool` | `true` | no |
| grafana\_port | Port hosting Grafana access | `number` | `31101` | no |
| image\_offer | The offer type of the Azure Virtual Machines Marketplace Image.<br>  (e.g. 'UbuntuServer', 'RHEL')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.offer) | `string` | `"UbuntuServer"` | no |
| image\_publisher | The publisher of the Azure Virtual Machines Marketplace Image.<br>  (e.g. 'Canonical', 'RedHat')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.publisher) | `string` | `"Canonical"` | no |
| image\_reference | The Azure Resource Manager (ARM) resource identifier of the Virtual Machine Image or Shared Image Gallery Image.<br>  Computes Compute Nodes of the Pool will be created using this Image Id.<br>  This is of the form `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageDefinitionName}/versions/{versionId}`.<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.virtualmachineimageid) | `string` | `null` | no |
| image\_sku | The Stock-Keeping Unit (SKU) of the Azure Virtual Machines Marketplace Image.<br>  (e.g. '18.04-LTS', '7.6')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.sku) | `string` | `"18.04-LTS"` | no |
| image\_version | The version of the Azure Virtual Machines Marketplace Image.<br>  (e.g. 'latest')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.version) | `string` | `"latest"` | no |
| ingress\_cidr\_blocks | CIDR blocks to attach to security groups for ingress | `list(string)` | `[]` | no |
| instance\_count | Number of VMs to create | `number` | `1` | no |
| kibana\_port | Port hosting Kibana access | `number` | `5601` | no |
| managed\_disk\_type | Managed disk type | `string` | `"Premium_LRS"` | no |
| persistence\_port | Port hosting Persistence access | `number` | `9080` | no |
| public\_ip | Public IP address to assign to the VM | `string` | `null` | no |
| tags | Map of tags to attach to VM and Network Interface | `map(string)` | `{}` | no |
| tamr\_port | Port hosting Tamr UI and API access | `number` | `9100` | no |
| vm\_name | Name of VM on which Tamr is installed | `string` | `"tamr-vm"` | no |
| zk\_port | Port hosting Zookeeper access | `number` | `21281` | no |

## Outputs

| Name | Description |
|------|-------------|
| nic\_ids | The ID(s) of the Network Interface(s) |
| sg\_id | The ID of the security group |
| vm\_ids | The ID(s) of the Tamr VM(s) |

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
