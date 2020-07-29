output "vm-module" {
  value       = module.vm
  description = "All resources created by the VM module"
}

output "vm-vnet-id" {
  value       = azurerm_virtual_network.vm-vnet.id
  description = "The virtual network created for the VM"
}

output "vm-subnet-id" {
  value       = azurerm_subnet.vm-subnet.id
  description = "The subnet created for the VM"
}
