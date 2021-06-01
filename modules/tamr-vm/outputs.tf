output "vm_ids" {
  value       = azurerm_virtual_machine.tamr-vm.*.id
  description = "The ID(s) of the Tamr VM(s)"
}

output "nic_ids" {
  value       = azurerm_network_interface.tamr-vm-nic.*.id
  description = "The ID(s) of the Network Interface(s)"
}

output "vm_ips" {
  value       = azurerm_network_interface.tamr-vm-nic.*.private_ip_address
  description = "The private IP(s) of the created resource(s)"
}
