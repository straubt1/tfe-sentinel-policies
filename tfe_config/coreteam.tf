resource "tfe_policy_set" "core" {
  name          = "core-policy-set"
  description   = "Core Team Policy Set"
  organization  = var.tfe_organization
  policies_path = "core-policies"

  vcs_repo {
    identifier     = var.vcs_config.identifier
    branch         = var.vcs_config.branch
    oauth_token_id = var.vcs_config.oauth_token_id
  }

  lifecycle {
    ignore_changes = [workspace_external_ids]
  }
}

resource "tfe_policy_set_parameter" "core-allowed_sizes" {
  policy_set_id = tfe_policy_set.core.id
  key           = "allowed_sizes"
  value = jsonencode(
    [
      "Standard_A1",
      "Standard_A2",
    ]
  )
}

resource "tfe_policy_set_parameter" "core-mandatory_tags" {
  policy_set_id = tfe_policy_set.core.id
  key           = "mandatory_tags"
  value = jsonencode(
    [
      "environment",
      "costcenter"
    ]
  )
}

resource "tfe_policy_set_parameter" "core-resource_type" {
  policy_set_id = tfe_policy_set.core.id
  key           = "resource_type"
  value         = "azurerm_resource_group"
}
