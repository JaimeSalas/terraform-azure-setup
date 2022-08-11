# PROVIDERS
# provider "azurerm" {
#   features {}
# }

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

resource "azurerm_subnet" "frontend" {
  name                 = "appGWSubnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.subnet_address_frontend]
}

resource "azurerm_subnet" "backend" {
  name                 = "vmsSubnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.subnet_address_backend]
}

# Create Public IP
resource "azurerm_public_ip" "pip" {
  name                = "appGatewayIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = local.comon_tags
}

data "azurerm_public_ip" "pip_data" {
  name                = "appGatewayIP"
  resource_group_name = azurerm_resource_group.rg.name
}


# Create network interface
resource "azurerm_network_interface" "nic1" {
  name                = "nic-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-ipconfig-1"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.ip.id
  }

  tags = local.comon_tags
}

resource "azurerm_network_interface" "nic2" {
  name                = "nic-2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-ipconfig-2"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.ip.id
  }

  tags = local.comon_tags
}
