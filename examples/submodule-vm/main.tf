data "azurerm_resource_group" "vm-rg" {
  name     = "tamrDevGroup"
}

resource "azurerm_virtual_network" "vm-vnet" {
  name = "example-submodule-vm-vm-vnet"

  location            = data.azurerm_resource_group.vm-rg.location
  resource_group_name = data.azurerm_resource_group.vm-rg.name

  address_space = ["1.2.3.0/25"]
}

resource "azurerm_subnet" "vm-subnet" {
  name = "example-submodule-vm-vm-subnet"

  resource_group_name = data.azurerm_resource_group.vm-rg.name

  virtual_network_name = azurerm_virtual_network.vm-vnet.name
  address_prefixes     = ["1.2.3.0/28"]
}

# create the VM as a standalone submodule by passing it the
# without a network security group
module "vm" {
  source = "../../modules/tamr-vm/"

  vm_name             = "example-submodule-vm-vm"
  resource_group_name = data.azurerm_resource_group.vm-rg.name
  location            = data.azurerm_resource_group.vm-rg.location
  subnet_id           = azurerm_subnet.vm-subnet.id
  vm_size             = "Standard_D2s_v3"
  managed_disk_type   = "Premium_LRS"
  disk_size_gb        = 100

  admin_username = "fakeUsername"
  ssh_key_data   = file("~/.ssh/id_rsa.pub")
}
