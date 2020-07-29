data "azurerm_resource_group" "vm-rg" {
  name     = "tamrDevGroup"
}

resource "azurerm_virtual_network" "vm-vnet" {
  name = "test-split-vm-vnet"

  location            = data.azurerm_resource_group.vm-rg.location
  resource_group_name = data.azurerm_resource_group.vm-rg.name

  address_space = ["1.2.3.0/25"]
}

resource "azurerm_subnet" "vm-subnet" {
  name = "test-split-vm-subnet"

  resource_group_name = data.azurerm_resource_group.vm-rg.name

  virtual_network_name = azurerm_virtual_network.vm-vnet.name
  address_prefixes     = ["1.2.3.0/28"]
}

resource "azurerm_application_security_group" "sg" {
  name                = "test-split-application-sg"
  location            = "East US 2"
  resource_group_name = data.azurerm_resource_group.vm-rg.name
}

# create the security group as a standalone submodule
module "network-security-group" {
  source = "../../modules/security-group/"

  vm_name             = "test-split-vm"
  resource_group_name = data.azurerm_resource_group.vm-rg.name
  location            = data.azurerm_resource_group.vm-rg.location

  ingress_cidr_blocks            = ["2.3.4.5/32"]
  application_security_group_ids = [azurerm_application_security_group.sg.id]
}

# create the VM as a standalone submodule by passing it the
# network security group's ID
module "vm" {
  source = "../../modules/vm/"

  vm_name             = "test-split-vm"
  resource_group_name = data.azurerm_resource_group.vm-rg.name
  location            = data.azurerm_resource_group.vm-rg.location
  subnet_id           = azurerm_subnet.vm-subnet.id
  vm_size             = "Standard_D2s_v3"
  managed_disk_type   = "Premium_LRS"
  disk_size_gb        = 100

  network_security_group_id = module.network-security-group.sg_id

  admin_username = "fakeUsername"
  ssh_key_data   = file("~/.ssh/id_rsa.pub")
}
