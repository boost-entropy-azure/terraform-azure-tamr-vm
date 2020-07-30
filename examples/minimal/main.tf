data "azurerm_resource_group" "vm-rg" {
  name     = "tamrDevGroup"
}

resource "azurerm_virtual_network" "vm-vnet" {
  name = "example-minimal-VirtualNetwork"

  location            = data.azurerm_resource_group.vm-rg.location
  resource_group_name = data.azurerm_resource_group.vm-rg.name

  address_space = ["1.2.3.0/25"]
}

resource "azurerm_subnet" "vm-subnet" {
  name = "example-minimal-Subnet"

  resource_group_name = data.azurerm_resource_group.vm-rg.name

  virtual_network_name = azurerm_virtual_network.vm-vnet.name
  address_prefixes     = ["1.2.3.0/28"]
}

resource "azurerm_application_security_group" "sg" {
  name                = "example-minimal-ApplicationSG"
  location            = data.azurerm_resource_group.vm-rg.location
  resource_group_name = data.azurerm_resource_group.vm-rg.name
}

module "vm" {
  source = "../../"

  vm_name             = "minimal-example-vm"
  resource_group_name = data.azurerm_resource_group.vm-rg.name
  location            = data.azurerm_resource_group.vm-rg.location
  subnet_id           = azurerm_subnet.vm-subnet.id
  vm_size             = "Standard_D2s_v3"
  managed_disk_type   = "Premium_LRS"
  disk_size_gb        = 100

  ingress_cidr_blocks            = ["2.3.4.5/32"]
  application_security_group_ids = [azurerm_application_security_group.sg.id]

  admin_username = "fakeUsername"
  ssh_key_data   = file("~/.ssh/id_rsa.pub")
}
