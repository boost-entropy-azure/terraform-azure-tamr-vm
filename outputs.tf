output "vm_ids" {
  value       = [azurerm_virtual_machine.tamr-vm.*.id]
  description = "The ID(s) of the Tamr VM(s)"
}

output "nic_ids" {
  value       = [azurerm_network_interface.tamr-vm-nic.*.id]
  description = "The ID(s) of the Network Interface(s)"
}

output "sg_id" {
  value       = azurerm_network_security_group.tamr-vm-sg.id
  description = "The ID of the security group"
}
