# INSTANCE
resource "azurerm_linux_virtual_machine" "vm1" {
  name                  = "webVM1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = var.vm_size
  zone                  = "1"

  os_disk {
    name                 = "osDisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "lemoncodevm"
  admin_username                  = "lemoncode"
  disable_password_authentication = false
  admin_password                  = "P4ssW85D!!!"

  custom_data = <<EOF
IyEgL2Jpbi9iYXNoCiMgSW5zdGFsbCBuZ2lueCB1c2luZyB0aGUgZGVmYXVsdCByZXBvc2l0b3J5
CnN1ZG8gYXB0IHVwZGF0ZQpzdWRvIGFwdCBpbnN0YWxsIG5naW54IC15CiMgUmVwbGFjZSBkZWZh
dWx0IGNvbnRlbnQKc3VkbyBybSAvdmFyL3d3dy9odG1sL2luZGV4Lm5naW54LWRlYmlhbi5odG1s
CmVjaG8gJzxodG1sPjxoZWFkPjx0aXRsZT5DYW1wZXJvIFNlcnZlcjwvdGl0bGU+PC9oZWFkPjxi
b2R5IHN0eWxlPVwiYmFja2dyb3VuZC1jb2xvcjojMUY3NzhEXCI+PHAgc3R5bGU9XCJ0ZXh0LWFs
aWduOiBjZW50ZXI7XCI+PHNwYW4gc3R5bGU9XCJjb2xvcjojRkZGRkZGO1wiPjxzcGFuIHN0eWxl
PVwiZm9udC1zaXplOjI4cHg7XCI+RG9uZSEgSGF2ZSBhICYjMTI5Mzg2Ozwvc3Bhbj48L3NwYW4+
PC9wPjwvYm9keT48L2h0bWw+JyB8IHN1ZG8gdGVlIC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbAo=
  EOF

  tags = local.comon_tags
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                  = "webVM2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic2.id]
  size                  = var.vm_size
  zone                  = "3"

  os_disk {
    name                 = "osDisk2"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "lemoncodevm"
  admin_username                  = "lemoncode"
  disable_password_authentication = false
  admin_password                  = "P4ssW85D!!!"

  custom_data = <<EOF
IyEgL2Jpbi9iYXNoCiMgSW5zdGFsbCBuZ2lueCB1c2luZyB0aGUgZGVmYXVsdCByZXBvc2l0b3J5
CnN1ZG8gYXB0IHVwZGF0ZQpzdWRvIGFwdCBpbnN0YWxsIG5naW54IC15CiMgUmVwbGFjZSBkZWZh
dWx0IGNvbnRlbnQKc3VkbyBybSAvdmFyL3d3dy9odG1sL2luZGV4Lm5naW54LWRlYmlhbi5odG1s
CmVjaG8gJzxodG1sPjxoZWFkPjx0aXRsZT5DYW1wZXJvIFNlcnZlcjwvdGl0bGU+PC9oZWFkPjxi
b2R5IHN0eWxlPVwiYmFja2dyb3VuZC1jb2xvcjojMUY3NzhEXCI+PHAgc3R5bGU9XCJ0ZXh0LWFs
aWduOiBjZW50ZXI7XCI+PHNwYW4gc3R5bGU9XCJjb2xvcjojRkZGRkZGO1wiPjxzcGFuIHN0eWxl
PVwiZm9udC1zaXplOjI4cHg7XCI+RG9uZSEgSGF2ZSBhICYjMTI5Mzg2Ozwvc3Bhbj48L3NwYW4+
PC9wPjwvYm9keT48L2h0bWw+JyB8IHN1ZG8gdGVlIC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbAo=
  EOF

  tags = local.comon_tags
}
