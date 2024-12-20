resource "azurerm_policy_definition" "storage_account_role_assignment" {
  name         = "storage-account-role-assigment"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "storage-account-role-assigment"

  metadata = <<METADATA
 {
   "category": "RBAC"
 }
 METADATA

  policy_rule = file("policy.json")

}

data "azurerm_subscription" "primary" {}

resource "azurerm_role_definition" "role_definition_depploy" {
  name               = "Deployment-tf"
  scope              = data.azurerm_subscription.primary.id

  permissions {
    actions     = ["Microsoft.Resources/deployments/write",
                    "Microsoft.Resources/deployments/validate/action"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

resource "azurerm_role_assignment" "roleAssignement_deploy" {
  scope                = "/subscriptions/52c93eeb-4017-4b73-9816-d8b8a92aff1e"
  role_definition_id   = azurerm_role_definition.role_definition_depploy.role_definition_resource_id
  principal_id         = azurerm_subscription_policy_assignment.tag_based_role_assignment.identity[0].principal_id

  depends_on = [azurerm_policy_definition.storage_account_role_assignment]
}


resource "azurerm_role_assignment" "roleAssignement_uaa" {
  scope                = "/subscriptions/52c93eeb-4017-4b73-9816-d8b8a92aff1e"
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_subscription_policy_assignment.tag_based_role_assignment.identity[0].principal_id

  depends_on = [azurerm_policy_definition.storage_account_role_assignment]
}

resource "azurerm_subscription_policy_assignment" "tag_based_role_assignment" {
  name                 = "tag-based-role-assignment"
  subscription_id      = "/subscriptions/52c93eeb-4017-4b73-9816-d8b8a92aff1e" //this is your subscription id
  policy_definition_id = azurerm_policy_definition.storage_account_role_assignment.id
  location             = "East US"
  identity {
    type = "SystemAssigned" //the assignment will need to have an identity (system or used managed) which can be used to assign the User Access Administrator RBAC role. 
  }
}