resource "azurerm_network_interface" "tamr-vm-nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.tamr_rg.name
  network_security_group_id = var.network_sec_gr_id

  ip_configuration {
    name                          = "${var.vm_name}-nic"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = var.public_ip
  }
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
}
