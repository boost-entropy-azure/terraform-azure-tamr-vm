variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

data "azurerm_resource_group" "tamr_rg" {
  name = var.resource_group_name
}

variable "location" {
  description = "Location"
  type        = string
}

variable "vm_size" {
  description = "Size of machine on which to deploy Tamr"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID in which to deploy VM"
  type        = string
}

variable "vm_name" {
  description = "Name of VM on which Tamr is installed"
  type        = string
  default     = "tamr-vm"
}

variable "ssh_key_data" {
  description = "SSH key"
  type        = string
}

variable "managed_disk_type" {
  description = "Managed disk type"
  type        = string
  default     = "Premium_LRS"
}

variable "disk_size_gb" {
  description = "Disk size"
  type        = number
  default     = 1000
}

variable "image_reference" {
  description = <<EOF
    The Azure Resource Manager (ARM) resource identifier of the Virtual Machine Image or Shared Image Gallery Image.
    Computes Compute Nodes of the Pool will be created using this Image Id.
    This is of the form `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageDefinitionName}/versions/{versionId}`.
    [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.virtualmachineimageid)
  EOF
  type        = string
  default     = null
}

variable "image_publisher" {
  description = <<EOF
  The publisher of the Azure Virtual Machines Marketplace Image.
  (e.g. 'Canonical', 'RedHat')
  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.publisher)
  EOF
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = <<EOF
  The offer type of the Azure Virtual Machines Marketplace Image.
  (e.g. 'UbuntuServer', 'RHEL')
  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.offer)
  EOF
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = <<EOF
  The Stock-Keeping Unit (SKU) of the Azure Virtual Machines Marketplace Image.
  (e.g. '18.04-LTS', '7.6')
  [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.sku)
  EOF
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = <<EOF
    The version of the Azure Virtual Machines Marketplace Image.
    (e.g. 'latest')
    [Azure Documentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.batch.imagereference.version)
  EOF
  type        = string
  default     = "latest"
}

variable "admin_username" {
  description = "Admin username"
  type        = string
  default     = "ubuntu"
}

variable "public_ip" {
  description = "Public IP address to assign to the VM"
  default     = null
  type        = string
}

variable "tags" {
  description = "Map of tags to attach to VM and Network Interface"
  type        = map(string)
  default     = {}
}

variable "instance_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "network_security_group_id" {
  description = "The id of the security group to use for this VM."
  type = string
  default = null
}

variable "standalone" {
  description = <<EOF
    Whether or not this module is standalone.
    Currently this only determines whether or not to create an
    association between the NIC and the provided security group.
  EOF
  type = bool
  default = true
}
