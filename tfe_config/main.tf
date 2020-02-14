variable "tfe_hostname" {
  description = "The domain where your TFE is hosted."
  default     = "app.terraform.io"
}

variable "tfe_organization" {
  description = "The TFE organization to apply your changes to."
}

variable "tfe_token" {
  description = "TFE Token to authenticate"
}

variable "vcs_config" {
  description = ""
  type = object({
    identifier     = string
    branch         = string
    oauth_token_id = string
  })
}

provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}
