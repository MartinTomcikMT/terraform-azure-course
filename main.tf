# TERRAFORM PROJECT 1.01

# Configure Azure Provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configure Azure provider featerues

provider "azurerm" {
  features {}
}

locals {
  environment_config = {
    default = {
      vm_size  = "Standard_B1s"
      vm_count = 1
    }

    dev = {
      vm_size  = "Standard_B1s"
      vm_count = 1
    }

    stage = {
      vm_size  = "Standard_B1s"
      vm_count = 1
    }

    prod = {
      vm_size  = "Standard_DS1_v2"
      vm_count = 2
    }
  }

  current_config = local.environment_config[terraform.workspace]
}


# Configure a resource group

resource "azurerm_resource_group" "main" {
  name     = "rg-${terraform.workspace}-${var.project_name}"
  location = var.location
  tags = {
    environment = terraform.workspace
    project     = "terraform-demo"
  }
}

# Create a Vritual network

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${terraform.workspace}-${var.project_name}"
  address_space       = var.address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = merge(var.tags, {
    project_code = "232324"
  })
}

# Create a subnet

resource "azurerm_subnet" "main" {
  name                 = "subnet-${terraform.workspace}-${var.project_name}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes

}

resource "azurerm_network_interface" "main" {
  count               = local.current_config.vm_count
  name                = "nic-${terraform.workspace}-${var.project_name}-${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ipconfig-${terraform.workspace}-${var.project_name}-${count.index + 1}"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = merge(var.tags, {
    environment  = terraform.workspace
    project_code = "121224"
  })
}