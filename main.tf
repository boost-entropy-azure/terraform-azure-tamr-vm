module "tamr-network-security-group" {
  source = "./modules/tamr-network-security-group/"

  resource_group_name = var.resource_group_name
  location            = var.location

  vm_name = var.vm_name

  ingress_cidr_blocks = var.ingress_cidr_blocks

  enable_tamr_port = var.enable_tamr_port
  tamr_port        = var.tamr_port

  enable_grafana_port = var.enable_grafana_port
  grafana_port        = var.grafana_port

  enable_elasticsearch_port = var.enable_elasticsearch_port
  elasticsearch_port        = var.elasticsearch_port

  enable_kibana_port = var.enable_kibana_port
  kibana_port        = var.kibana_port

  enable_auth_port = var.enable_auth_port
  auth_port        = var.auth_port

  enable_persistence_port = var.enable_persistence_port
  persistence_port        = var.persistence_port

  enable_zk_port = var.enable_zk_port
  zk_port        = var.zk_port

  enable_tls = var.enable_tls
  enable_ssh = var.enable_ssh

  application_security_group_ids = var.application_security_group_ids
  tags                           = var.tags
}

module "tamr-vm" {
  source = "./modules/tamr-vm/"

  instance_count = var.instance_count

  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = var.vm_name

  vm_size = var.vm_size

  subnet_name                     = var.subnet_name
  vnet_name                       = var.vnet_name
  existing_network_resource_group = var.existing_network_resource_group
  path_to_ssh_key                 = var.path_to_ssh_key

  managed_disk_type = var.managed_disk_type
  disk_size_gb      = var.disk_size_gb

  image_reference = var.image_reference
  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku
  image_version   = var.image_version

  admin_username = var.admin_username
  public_ip      = var.public_ip
  tags           = var.tags

  network_security_group_id = module.tamr-network-security-group.sg_id
  standalone                = false
}
