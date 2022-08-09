# PROVIDERS
provider "azurerm" {
  features {}
}

# RESOURCES
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location

  tags = local.comon_tags
}

# NETWORKING
resource "azurerm_virtual_network" "vnet" {
  name                = "lcVnet"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = local.comon_tags
}

resource "azurerm_subnet" "subnet" {
  name = "lcSubnet"
  #   location            = azurerm_resource_group.rg.location
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.subnet_address_prefix]
}

# Create Public IP
resource "azurerm_public_ip" "ip" {
  name                = "lemoncodeIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"

  tags = local.comon_tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "lcSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = var.rule_priorities[0]
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = var.rule_priorities[1]
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.comon_tags
}

resource "azurerm_subnet_network_security_group_association" "sga" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = "lcNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "lcNicConf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }

  tags = local.comon_tags
}

# INSTANCE
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "webVM"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size

  os_disk {
    name                 = "osDisk"
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
