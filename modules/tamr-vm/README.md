# Tamr Azure VM module

This module creates an Azure VM to host the Tamr application and its
internal microservices.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "minimal" {
  source = "git::https://github.com/Datatamer/terraform-azure-tamr-vm//modules/tamr-vm?ref=1.0.0"
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >= 2.60.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.60.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| location | Location | `string` | n/a | yes |
| path\_to\_ssh\_key | Local file path to a public SSH key | `string` | n/a | yes |
| resource\_group\_name | Name of resource group | `string` | n/a | yes |
| subnet\_id | Subnet ID in which to deploy VM | `string` | n/a | yes |
| vm\_size | Size of machine on which to deploy Tamr | `string` | n/a | yes |
| admin\_username | Admin username | `string` | `"ubuntu"` | no |
| disk\_size\_gb | Disk size | `number` | `1000` | no |
| image\_offer | The offer type of the Azure Virtual Machines Marketplace Image.<br>  (e.g. 'UbuntuServer', 'RHEL')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.offer) | `string` | `"UbuntuServer"` | no |
| image\_publisher | The publisher of the Azure Virtual Machines Marketplace Image.<br>  (e.g. 'Canonical', 'RedHat')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.publisher) | `string` | `"Canonical"` | no |
| image\_reference | The Azure Resource Manager (ARM) resource identifier of the Virtual Machine Image or Shared Image Gallery Image.<br>  Computes Compute Nodes of the Pool will be created using this Image Id.<br>  This is of the form `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageDefinitionName}/versions/{versionId}`.<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.virtualmachineimageid) | `string` | `null` | no |
| image\_sku | The Stock-Keeping Unit (SKU) of the Azure Virtual Machines Marketplace Image.<br>  (e.g. '18.04-LTS', '7.6')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.sku) | `string` | `"18.04-LTS"` | no |
| image\_version | The version of the Azure Virtual Machines Marketplace Image.<br>  (e.g. 'latest')<br>  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.version) | `string` | `"latest"` | no |
| instance\_count | Number of VMs to create | `number` | `1` | no |
| managed\_disk\_type | Managed disk type | `string` | `"Premium_LRS"` | no |
| network\_security\_group\_id | The id of the security group to use for this VM. | `string` | `null` | no |
| public\_ip | Public IP address to assign to the VM | `string` | `null` | no |
| standalone | Whether or not this module is standalone.<br>  Currently this only determines whether or not to create an<br>  association between the NIC and the provided security group. | `bool` | `true` | no |
| tags | Map of tags to attach to VM and Network Interface | `map(string)` | `{}` | no |
| vm\_name | Name of VM on which Tamr is installed | `string` | `"tamr-vm"` | no |

## Outputs

| Name | Description |
|------|-------------|
| nic\_ids | The ID(s) of the Network Interface(s) |
| vm\_ids | The ID(s) of the Tamr VM(s) |
| vm\_ips | The private IP(s) of the created resource(s) |

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
