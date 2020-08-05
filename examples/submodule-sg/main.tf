resource "azurerm_resource_group" "vm-rg" {
  name     = "azure-tamr-vm-sg-example"
  location = "East US 2"
}

resource "azurerm_application_security_group" "sg" {
  name                = "example-submodule-sg-application-sg"
  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name
}

# create the security group as a standalone submodule
module "network-security-group" {
  source = "../../modules/tamr-network-security-group/"

  vm_name             = "example-submodule-sg-vm-subnet"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = azurerm_resource_group.vm-rg.location

  ingress_cidr_blocks            = ["2.3.4.5/32"]
  application_security_group_ids = [azurerm_application_security_group.sg.id]
}
