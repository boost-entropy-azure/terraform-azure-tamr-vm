variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
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

variable "path_to_ssh_key" {
  description = "Local file path to a public SSH key"
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

variable "tamr_port" {
  description = "Port hosting Tamr UI and API access"
  default     = 9100
  type        = number
}

variable "enable_tamr_port" {
  description = "Whether or not to enable Tamr API access"
  default     = true
  type        = bool
}

variable "kibana_port" {
  description = "Port hosting Kibana access"
  default     = 5601
  type        = number
}

variable "grafana_port" {
  description = "Port hosting Grafana access"
  default     = 31101
  type        = number
}

variable "elasticsearch_port" {
  description = "Port hosting Elasticsearch access"
  default     = 9200
  type        = number
}

variable "enable_kibana_port" {
  description = "Whether or not to enable Kibana"
  default     = true
  type        = bool
}

variable "enable_grafana_port" {
  description = "Whether or not to enable Grafana"
  default     = true
  type        = bool
}

variable "enable_tls" {
  description = "Whether or not to enable TLS"
  default     = true
  type        = bool
}

variable "enable_ssh" {
  description = "Whether or not to enable SSH"
  default     = true
  type        = bool
}

variable "enable_elasticsearch_port" {
  description = "Whether or not to enable Elasticsearch"
  default     = true
  type        = bool
}

variable "enable_auth_port" {
  description = "Whether or not to enable Auth"
  default     = true
  type        = bool
}

variable "auth_port" {
  description = "Port hosting Auth access"
  default     = 9020
  type        = number
}

variable "enable_persistence_port" {
  description = "Whether or not to enable Persistence"
  default     = true
  type        = bool
}

variable "persistence_port" {
  description = "Port hosting Persistence access"
  default     = 9080
  type        = number
}

variable "enable_zk_port" {
  description = "Whether or not to enable Zookeeper"
  default     = true
  type        = bool
}

variable "zk_port" {
  description = "Port hosting Zookeeper access"
  default     = 21281
  type        = number
}

variable "application_security_group_ids" {
  description = "List of Application security group IDs"
  type        = list(string)
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks to attach to security groups for ingress"
  type        = list(string)
  default     = []
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
