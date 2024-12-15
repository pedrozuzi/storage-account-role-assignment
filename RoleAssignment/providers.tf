terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.115.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "zuziterraformstate"
    container_name       = "asr"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  tenant_id       = var.arm_tenant_id
}