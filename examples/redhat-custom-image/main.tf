resource "azurerm_resource_group" "vm-rg" {
  name     = "azure-tamr-redhat-custom-image-example"
  location = "East US 2"
}

resource "azurerm_virtual_network" "vm-vnet" {
  name = "example-redhat-VirtualNetwork"

  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name

  address_space = ["1.2.3.0/25"]
}

resource "azurerm_subnet" "vm-subnet" {
  name = "example-redhat-Subnet"

  resource_group_name = azurerm_resource_group.vm-rg.name

  virtual_network_name = azurerm_virtual_network.vm-vnet.name
  address_prefixes     = ["1.2.3.0/28"]
}

resource "azurerm_application_security_group" "sg" {
  name                = "example-redhat-ApplicationSG"
  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name
}

module "vm" {
  source = "../../"

  vm_name             = "redhat-example-vm"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = azurerm_resource_group.vm-rg.location
  subnet_id           = azurerm_subnet.vm-subnet.id
  vm_size             = "Standard_D2s_v3"
  managed_disk_type   = "Premium_LRS"
  disk_size_gb        = 100

  image_publisher     = "RedHat"
  image_offer         = "RHEL"
  image_sku           = "7.6"
  image_version       = "latest"

  ingress_cidr_blocks            = ["2.3.4.5/32"]
  application_security_group_ids = [azurerm_application_security_group.sg.id]

  admin_username = "fakeUsername"
  ssh_key_data   = file("~/.ssh/id_rsa.pub")
}
