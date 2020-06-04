resource "azurerm_network_interface" "tamr-vm-nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name

  ip_configuration {
    name                          = "${var.vm_name}-nic"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = var.public_ip
  }
  
  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nsg-assoc" {
  network_interface_id = azurerm_network_interface.tamr-vm-nic.id
  network_security_group_id = azurerm_network_security_group.tamr-vm-sg.id
}

locals {
  resource_from_id = "${var.image_reference != null ? true : false}"
}

resource "azurerm_virtual_machine" "tamr-vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_interface_ids = [
    azurerm_network_interface.tamr-vm-nic.id,
  ]

  vm_size = var.machine_type

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    # If image ID is defined, use that. Else use Ubuntu 18.04 image
    id = var.image_reference

    publisher = local.resource_from_id ? "" : "Canonical"
    offer     = local.resource_from_id ? "" : "UbuntuServer"
    sku       = local.resource_from_id ? "" : "18.04-LTS"
    version   = local.resource_from_id ? "" : "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
    disk_size_gb      = var.disk_size_gb
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.ssh_key_data
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }
  
  tags = var.tags
}

resource "azurerm_network_security_group" "tamr-vm-sg" {
  name                = "${var.vm_name}-sg"
  location            = data.azurerm_resource_group.tamr_rg.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name

  tags = var.tags
}

resource "azurerm_network_security_rule" "tamr-rule" {
  name = "Tamr"
  description = "Tamr UI and API access from allowed CIDR blocks"
  direction = "Inbound"
  priority = 1001
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = var.tamr_port

  destination_address_prefix = "*"
  destination_port_range = var.tamr_port

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "kibana-rule" {
  count = var.enable_kibana_port ? 1 : 0

  name = "Kibana"
  description = "Kibana port"
  direction = "Inbound"
  priority = 1002
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = var.kibana_port

  destination_address_prefix = "*"
  destination_port_range = var.kibana_port

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "grafana-rule" {
  count = var.enable_grafana_port ? 1 : 0

  name = "Grafana"
  description = "Grafana port"
  direction = "Inbound"
  priority = 1003
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = var.grafana_port

  destination_address_prefix = "*"
  destination_port_range = var.grafana_port

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "tls-rule" {
  count = var.enable_tls ? 1 : 0

  name = "HTTPS"
  description = "TLS from allowed CIDR blocks"
  direction = "Inbound"
  priority = 1004
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = 443

  destination_address_prefix = "*"
  destination_port_range = 443

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "es-rule" {
  count = var.enable_elasticsearch_port ? 1 : 0

  name = "Elasticsearch"
  description = "Elasticsearch from allowed CIDR blocks"
  direction = "Inbound"
  priority = 1007
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = "*"

  destination_address_prefix = "*"
  destination_port_range = var.elasticsearch_port

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "ssh-rule" {
  count = var.enable_ssh ? 1 : 0

  name = "SSH"
  description = "SSH from allowed CIDR blocks"
  direction = "Inbound"
  priority = 1005
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = "*"

  destination_address_prefix = "*"
  destination_port_range = 22

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "http-rule" {
  name = "HTTP"
  description = "HTTP from allowed CIDR blocks"
  direction = "Inbound"
  priority = 1006
  access = "Allow"
  protocol = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range = 80

  destination_address_prefix = "*"
  destination_port_range = 80

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "app-group-tamr" {
  name = "Application security groups Tamr"
  description = "Traffic from allow application security groups to Tamr APIs"
  direction = "Inbound"
  priority = 1009
  access = "Allow"
  protocol = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range = "*"

  destination_address_prefix = "*"
  destination_port_range = var.tamr_port

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "app-group-es" {
  count = var.enable_elasticsearch_port ? 1 : 0

  name = "Application security groups Elasticsearch"
  description = "Traffic from allow application security groups to Elasticsearch APIs"
  direction = "Inbound"
  priority = 1008
  access = "Allow"
  protocol = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range = "*"

  destination_address_prefix = "*"
  destination_port_range = var.elasticsearch_port

  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}
