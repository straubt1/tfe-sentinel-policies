resource "tfe_policy_set" "global" {
  name          = "global-policy-set"
  description   = "Global Policy Set"
  organization  = var.tfe_organization
  policies_path = "global"
  global        = true

  vcs_repo {
    identifier     = var.vcs_config.identifier
    branch         = var.vcs_config.branch
    oauth_token_id = var.vcs_config.oauth_token_id
  }

  lifecycle {
    ignore_changes = [workspace_external_ids]
  }
}

resource "tfe_policy_set_parameter" "global-allowed_sizes" {
  policy_set_id = tfe_policy_set.global.id
  key           = "allowed_sizes"
  value = jsonencode(
    [
      "Standard_A1",
      "Standard_A2",
    ]
  )
}

resource "tfe_policy_set_parameter" "global-mandatory_tags" {
  policy_set_id = tfe_policy_set.global.id
  key           = "mandatory_tags"
  value = jsonencode(
    [
      "environment",
      "costcenter"
    ]
  )
}

resource "tfe_policy_set_parameter" "global-resource_type" {
  policy_set_id = tfe_policy_set.global.id
  key           = "resource_type"
  value         = "azurerm_resource_group"
}
