# Common
variable "rg_location" {
  type        = string
  description = "Location for resource group"
  default     = "francecentral"
}

variable "rg_name" {
  type        = string
  description = "Name for resource group"
  default     = "lemoncode"
}

variable "company" {
  type = string
  description = "Company name"
  default = "Lemoncode"
}

variable "project" {
  type = string
  description = "Company name"
  default = "sandwich"
}

variable "billing_code" {
  type = string
  description = "Company name"
  default = "BF-0000222"
}

# Networking
variable "vnet_address_space" {
  type        = string
  description = "VNet CIDR Block"
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  type        = string
  description = "VNet CIDR Block"
  default     = "10.0.1.0/24"
}

# Security group 
variable "rule_priorities" {
  type        = list(number)
  description = "Priority of security groups"
  default     = [1001, 1000]
}

# Instance
variable "vm_size" {
  type        = string
  description = "Size of VM"
  default     = "Standard_DS1_v2"
}