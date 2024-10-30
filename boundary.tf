# OpenShift Console Target
module "openshift_console_target" {
  source               = "github.com/tfo-apj-demos/terraform-boundary-target-refactored"

  project_name         = "gcve_admins"
  target_name          = "OpenShift"
  hosts                = ["console-openshift-console.apps.openshift-01.hashicorp.local"]
  port                 = 443
  target_type          = "tcp"

  # Vault credential configurations
  use_credentials      = false

  # Alias name for accessing the AAP Openshift Console
  alias_name           = "console-openshift-console.apps.openshift-01.hashicorp.local"
}

# Oauth Target for Openshift Console
module "oauth_target" {
  source               = "github.com/tfo-apj-demos/terraform-boundary-target-refactored"

  project_name         = "gcve_admins"
  target_name          = "OAuth for OpenShift"
  hosts                = ["oauth-openshift.apps.openshift-01.hashicorp.local"]
  port                 = 443
  target_type          = "tcp"

  # Vault credential configurations
  use_credentials      = false

  # Alias name for accessing the AAP Openshift Console
  alias_name           = "oauth-openshift.apps.openshift-01.hashicorp.local"
}