resource "tfe_policy_set" "app" {
  name          = "app-policy-set"
  description   = "App Team Policy Set"
  organization  = var.tfe_organization
  policies_path = "app-policies"

  vcs_repo {
    identifier     = var.vcs_config.identifier
    branch         = var.vcs_config.branch
    oauth_token_id = var.vcs_config.oauth_token_id
  }

  lifecycle {
    ignore_changes = [workspace_external_ids]
  }
}

resource "tfe_policy_set_parameter" "app-allowed_sizes" {
  policy_set_id = tfe_policy_set.app.id
  key           = "allowed_sizes"
  value = jsonencode(
    [
      "Standard_A1",
      "Standard_A2",
    ]
  )
}

resource "tfe_policy_set_parameter" "app-mandatory_tags" {
  policy_set_id = tfe_policy_set.app.id
  key           = "mandatory_tags"
  value = jsonencode(
    [
      "environment",
      "costcenter"
    ]
  )
}

resource "tfe_policy_set_parameter" "app-resource_type" {
  policy_set_id = tfe_policy_set.app.id
  key           = "resource_group_name"
  value         = "tstraub-rg"
}
