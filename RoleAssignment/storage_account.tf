resource "azurerm_storage_account" "primary_storage_account" {
  name                     = "primaryzuzicache001"
  location                 = azurerm_resource_group.rg_role_assignment.location
  resource_group_name      = azurerm_resource_group.rg_role_assignment.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    env = "role"
  }
}

resource "azurerm_storage_account" "primary_storage_account_1" {
  name                     = "primaryzuzicache0011"
  location                 = azurerm_resource_group.rg_role_assignment.location
  resource_group_name      = azurerm_resource_group.rg_role_assignment.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "primary_storage_account_2" {
  name                     = "primaryzuzi222222"
  location                 = azurerm_resource_group.rg_role_assignment.location
  resource_group_name      = azurerm_resource_group.rg_role_assignment.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    env = "role"
  }
}