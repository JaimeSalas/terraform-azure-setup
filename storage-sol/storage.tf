# azurerm_storage_account
resource "azurerm_storage_account" "sa" {
  name                     = "lemoncode"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# azurerm_storage_container
resource "azurerm_storage_container" "sc" {
  name                  = local.storage_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}

# azurerm_storage_blob
resource "azurerm_storage_blob" "html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc.name
  type                   = "Block"
  source                 = "website/index.html"
}

resource "azurerm_storage_blob" "png" {
  name                   = "fruits.png"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc.name
  type                   = "Block"
  source                 = "website/fruits.png"
}
