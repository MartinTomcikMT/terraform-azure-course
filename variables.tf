variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "North europe"
}

variable "environment" {
  description = "Environment which will have created resource: dev, stage, prod"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "Name of the resource group "
  type        = string
  default     = "rg-terraform-demo"
}

variable "tags" {
  description = "Tags to apply resources"
  type        = map(string)
  default = {
    managed_by  = "terraform"
    cost_center = "engineering"
    devops      = "devops-team"
  }
}

variable "virtual_network_name" {
  description = "Name of virtual network"
  type        = string
  default     = "vnet-terraform-demo"
}

variable "address_space" {
  description = "The address space of virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "subnet_address_prefixes" {
  description = "The adress prefixes for subnet"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "project_name" {
  description = "The project name"
  type        = string
}