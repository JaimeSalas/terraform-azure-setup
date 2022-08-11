output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "public_ip_address" {
  value = data.azurerm_public_ip.pip_data
}

output "html_url" {
  value = azurerm_storage_blob.html
}

output "png_url" {
  value = azurerm_storage_blob.png
}