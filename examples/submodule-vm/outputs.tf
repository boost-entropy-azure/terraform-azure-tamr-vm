output "vm-module" {
  value       = module.vm
  description = "All resources created by the VM module"
}

output "vm-subnet-id" {
  value       = azurerm_subnet.vm-subnet.id
  description = "The subnet created for the VM"
}
