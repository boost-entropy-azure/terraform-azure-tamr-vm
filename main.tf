resource "azurerm_network_interface" "tamr-vm-nic" {
  count = var.instance_count

  name                = "${var.vm_name}-${count.index}-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name

  ip_configuration {
    name                          = "${var.vm_name}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = var.public_ip
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nsg-assoc" {
  count = var.instance_count

  network_interface_id      = azurerm_network_interface.tamr-vm-nic[count.index].id
  network_security_group_id = azurerm_network_security_group.tamr-vm-sg.id
}

resource "azurerm_virtual_machine" "tamr-vm" {
  count = var.instance_count

  name                = "${var.vm_name}-${count.index}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name

  network_interface_ids = [
    azurerm_network_interface.tamr-vm-nic[count.index].id,
  ]

  vm_size = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    # if image ID is defined, use that
    id = var.image_reference

    # if an image reference id is provided, these variables should be empty
    # else if the user provided their own image reference values, use those
    # else use the default Ubuntu 18.04 image
    publisher = var.image_reference != null ? "" : var.image_publisher
    offer     = var.image_reference != null ? "" : var.image_offer
    sku       = var.image_reference != null ? "" : var.image_sku
    version   = var.image_reference != null ? "" : var.image_version
  }

  storage_os_disk {
    name              = "${var.vm_name}-disk-${count.index}"
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
  count = var.enable_tamr_port ? 1 : 0

  name        = "Tamr"
  description = "Tamr UI and API access from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1001
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.tamr_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "kibana-rule" {
  count = var.enable_kibana_port ? 1 : 0

  name        = "Kibana"
  description = "Kibana port"
  direction   = "Inbound"
  priority    = 1002
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.kibana_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "grafana-rule" {
  count = var.enable_grafana_port ? 1 : 0

  name        = "Grafana"
  description = "Grafana port"
  direction   = "Inbound"
  priority    = 1003
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.grafana_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "tls-rule" {
  count = var.enable_tls ? 1 : 0

  name        = "HTTPS"
  description = "TLS from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1004
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = 443

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "es-rule" {
  count = var.enable_elasticsearch_port ? 1 : 0

  name        = "Elasticsearch"
  description = "Elasticsearch from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1005
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.elasticsearch_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "ssh-rule" {
  count = var.enable_ssh ? 1 : 0

  name        = "SSH"
  description = "SSH from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1006
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = 22

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "http-rule" {
  name        = "HTTP"
  description = "HTTP from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1007
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = 80

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "auth-rule" {
  count = var.enable_auth_port ? 1 : 0

  name        = "Auth"
  description = "Auth from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1008
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.auth_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "persistence-rule" {
  count = var.enable_persistence_port ? 1 : 0

  name        = "Persistence"
  description = "Persistence from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1009
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.persistence_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "zk-rule" {
  count = var.enable_zk_port ? 1 : 0

  name        = "ZK"
  description = "Zookeeper from allowed CIDR blocks"
  direction   = "Inbound"
  priority    = 1010
  access      = "Allow"
  protocol    = "Tcp"

  source_address_prefixes = var.ingress_cidr_blocks
  source_port_range       = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.zk_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "tamr-app-group-rule" {
  count = var.enable_tamr_port ? 1 : 0

  name        = "App security group Tamr"
  description = "Tamr UI and API access from allowed application security groups"
  direction   = "Inbound"
  priority    = 1011
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.tamr_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "kibana-app-group-rule" {
  count = var.enable_kibana_port ? 1 : 0

  name        = "App security group Kibana"
  description = "Kibana port from allowed application security groups"
  direction   = "Inbound"
  priority    = 1012
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.kibana_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "grafana-app-group-rule" {
  count = var.enable_grafana_port ? 1 : 0

  name        = "App security group Grafana"
  description = "Grafana port from allowed application security groups"
  direction   = "Inbound"
  priority    = 1013
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.grafana_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "tls-app-group-rule" {
  count = var.enable_tls ? 1 : 0

  name        = "App security group HTTPS"
  description = "TLS from allowed application security groups"
  direction   = "Inbound"
  priority    = 1014
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = 443

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "es-app-group-rule" {
  count = var.enable_elasticsearch_port ? 1 : 0

  name        = "App security group Elasticsearch"
  description = "Elasticsearch from allowed application security groups"
  direction   = "Inbound"
  priority    = 1015
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.elasticsearch_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "ssh-app-group-rule" {
  count = var.enable_ssh ? 1 : 0

  name        = "App security group SSH"
  description = "SSH from allowed application security groups"
  direction   = "Inbound"
  priority    = 1016
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = 22

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "http-app-group-rule" {
  name        = "App security group HTTP"
  description = "HTTP from allowed application security groups"
  direction   = "Inbound"
  priority    = 1017
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = 80

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "auth-app-group-rule" {
  count = var.enable_auth_port ? 1 : 0

  name        = "App security group Auth"
  description = "Auth from allowed application security groups"
  direction   = "Inbound"
  priority    = 1018
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.auth_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "persistence-app-group-rule" {
  count = var.enable_persistence_port ? 1 : 0

  name        = "App security group Persistence"
  description = "Persistence from allowed application security groups"
  direction   = "Inbound"
  priority    = 1019
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.persistence_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}

resource "azurerm_network_security_rule" "zk-app-group-rule" {
  count = var.enable_zk_port ? 1 : 0

  name        = "App security group ZK"
  description = "Zookeeper from allowed application security groups"
  direction   = "Inbound"
  priority    = 1020
  access      = "Allow"
  protocol    = "Tcp"

  source_application_security_group_ids = var.application_security_group_ids
  source_port_range                     = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.zk_port

  resource_group_name         = data.azurerm_resource_group.tamr_rg.name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}
