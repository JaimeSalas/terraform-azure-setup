output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "public_ip_address" {
  value = data.azurerm_public_ip.pip_data
}