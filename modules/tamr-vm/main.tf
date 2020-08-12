resource "azurerm_network_interface" "tamr-vm-nic" {
  count = var.instance_count

  name                = "${var.vm_name}-${count.index}-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name

  ip_configuration {
    name                          = "${var.vm_name}-nic"
    subnet_id                     = data.azurerm_subnet.subnet_selected.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = var.public_ip
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nsg-assoc" {
  count = var.standalone ? 0 : var.instance_count

  network_interface_id      = azurerm_network_interface.tamr-vm-nic[count.index].id
  network_security_group_id = var.network_security_group_id
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
      key_data = file(var.path_to_ssh_key)
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }

  tags = var.tags
}
