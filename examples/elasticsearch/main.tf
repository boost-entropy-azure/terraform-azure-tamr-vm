resource "azurerm_resource_group" "es-rg" {
  name     = "tamrEsResourceGroup"
  location = "East US"
}

resource "azurerm_virtual_network" "es-vnet" {
  name = "tamrEsVirtualNetwork"

  location            = azurerm_resource_group.es-rg.location
  resource_group_name = azurerm_resource_group.es-rg.name

  address_space = ["1.2.3.0/25"]
}

resource "azurerm_subnet" "es-subnet" {
  name = "tamrEsSubnet"

  resource_group_name = azurerm_resource_group.es-rg.name

  virtual_network_name = azurerm_virtual_network.es-vnet.name
  address_prefixes     = ["1.2.3.0/28"]
}

resource "azurerm_application_security_group" "sg" {
  name                = "esApplicationSG"
  location            = "East US"
  resource_group_name = azurerm_resource_group.es-rg.name
}

module "es" {
  source         = "../../"
  instance_count = 3

  vm_name             = "es-example-vm"
  resource_group_name = azurerm_resource_group.es-rg.name
  location            = azurerm_resource_group.es-rg.location
  subnet_id           = azurerm_subnet.es-subnet.id
  vm_size             = "Standard_D2s_v3"
  managed_disk_type   = "Premium_LRS"
  disk_size_gb        = 100

  ingress_cidr_blocks            = ["2.3.4.5/32"]
  application_security_group_ids = [azurerm_application_security_group.sg.id]

  enable_elasticsearch_port = true

  enable_kibana_port      = false
  enable_grafana_port     = false
  enable_tls              = false
  enable_ssh              = false
  enable_auth_port        = false
  enable_persistence_port = false
  enable_zk_port          = false
  enable_tamr_port        = false

  admin_username  = "fakeUsername"
  path_to_ssh_key = "~/.ssh/id_rsa.pub"
}
