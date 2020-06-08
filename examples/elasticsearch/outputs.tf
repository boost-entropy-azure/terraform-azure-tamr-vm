output "es-module" {
  value       = module.es
  description = "All resources created by the Elasticsearch vm module"
}
output "es-vnet-id" {
  value       = azurerm_virtual_network.es-vnet.id
  description = "The virtual network created for the Elasticseach cluster"
}

output "es-resource-group-id" {
  value       = azurerm_resource_group.es-rg.id
  description = "The resource group created for the Elasticsearch cluster"
}

output "es-subnet-id" {
  value       = azurerm_subnet.es-subnet.id
  description = "The subnet created for the Elasticsearch cluster"
}
