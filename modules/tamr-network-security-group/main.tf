resource "azurerm_network_security_group" "tamr-vm-sg" {
  name                = "${var.vm_name}-sg"
  location            = var.location
  resource_group_name = var.resource_group_name

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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.tamr_port

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.kibana_port

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.grafana_port

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = 443

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.elasticsearch_port

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = 22

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = 80

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.auth_port

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.persistence_port

  resource_group_name         = var.resource_group_name
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
  source_address_prefix                 = "*"

  destination_address_prefix = "*"
  destination_port_range     = var.zk_port

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.tamr-vm-sg.name
}
