variable "resource_group_name" {
    description = "Name of resource group"
    type = string
}

data "azurerm_resource_group" "tamr_rg" {
    name = var.resource_group_name
}

variable "location" {
    description = "Location"
    type = string
}

variable "machine_type" {
    description = "Type of machine on which to deploy Tamr"
    type = string
}

variable "vnet_id" {
    description = "Virtual network in which to deploy VM"
    type = string
}

variable "subnet_id" {
    description = "Subnet in which to deploy VM"
    type = string
}

data "azurerm_subnet" "subnet" {
    resource_group_name = var.existing_network_resource_group
    virtual_network_name = var.vnet_id
    name = var.subnet_id
}

variable "existing_network_resource_group" {
    description = "Resource group which owns the VNet"
    type = string
}

variable "vm_name" {
    description = "Name of VM on which Tamr is installed"
    type = string
    default = "tamr-vm"
}

variable "ssh_key_data" {
    description = "SSH key"
    type = string
}

variable "managed_disk_type" {
    description = "Managed disk type"
    type = string
    default = "Premium_LRS"
}

variable "disk_size_gb" {
    description = "Disk size"
    type = number
    default = 1000
}

variable "image_reference" {
    description = "Base image for VM"
    type = string
    default = null
}

variable "admin_username" {
    description = "Admin username"
    type = string
    default = "ubuntu"
}

variable "network_sec_gr_id" {
    default = null
    type = string
}

variable "public_ip" {
    default = null
    type = string
}

variable "tamr_port" {
    description = "Port hosting Tamr UI and API access"
    default = 9100
    type = number
}

variable "kibana_port" {
    description = "Port hosting Kibana access"
    default = 5601
    type = number
}

variable "grafana_port" {
    description = "Port hosting Grafana access"
    default = 31101
    type = number
}

variable "enable_kibana_port" {
    description = "Whether or not to enable Kibana"
    default = true
    type = bool
}

variable "enable_grafana_port" {
    description = "Whether or not to enable Grafana"
    default = true
    type = bool
}

variable "enable_tls" {
    description = "Whether or not to enable TLS"
    default = true
    type = bool
}

variable "enable_ssh" {
    description = "Whether or not to enable SSH"
    default = true
    type = bool
}

variable "ingress_cidr_blocks" {
  type = list(string)
  description = "CIDR blocks to attach to security groups for ingress"
  default = []
}

variable "tags" {
    type = map(string)
    description = "Map of tags to attach to VM and Network Interface"
    default = {}
}
