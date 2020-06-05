output "vm_id" {
  value       = azurerm_virtual_machine.tamr-vm.id
  description = "The ID of the Tamr VM"
}

output "nic_id" {
  value       = azurerm_network_interface.tamr-vm-nic.id
  description = "The ID of the Network Interface"
}

output "sg_id" {
  value       = azurerm_network_security_group.tamr-vm-sg.id
  description = "The ID of the security group"
}
