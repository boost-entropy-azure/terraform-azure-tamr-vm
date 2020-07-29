output "vm_ids" {
  value       = module.tamr-vm.vm_ids
  description = "The ID(s) of the Tamr VM(s)"
}

output "nic_ids" {
  value       = module.tamr-vm.nic_ids
  description = "The ID(s) of the Network Interface(s)"
}

output "sg_id" {
  value       = module.tamr-network-security-group.sg_id
  description = "The ID of the security group"
}
