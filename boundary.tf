module "openshift_target" {
  source  = "app.terraform.io/tfo-apj-demos/target/boundary"
  version = "~> 2.0.1"

  project_name           = "gcve_admins"
  hostname_prefix        = "On-Prem Openshift Console"

  hosts = [{
    fqdn  = "console-openshift-console.apps.openshift-01.hashicorp.local"
  }]

  services = [{
    type             = "tcp"
    port             = 443
    use_existing_creds = false
    use_vault_creds    = false
  }]
}

module "oauth_target" {
  source  = "app.terraform.io/tfo-apj-demos/target/boundary"
  version = "~> 2.0.1"

  project_name           = "gcve_admins"
  hostname_prefix        = "OAuth Openshift Console"

  hosts = [{
    fqdn  = "oauth-openshift.apps.openshift-01.hashicorp.local"
  }]

  services = [{
    type             = "tcp"
    port             = 443
    use_existing_creds = false
    use_vault_creds    = false
  }]
}

# create another target for controller-aap.apps.openshift-01.hashicorp.local
module "controller_target" {
  source = "app.terraform.io/tfo-apj-demos/target/boundary"
  version = "~> 2.0.1"

  project_name           = "gcve_admins"
  hostname_prefix        = "Controller Openshift Console"

  hosts = [{
    fqdn  = "controller-aap.apps.openshift-01.hashicorp.local"
  }]

  services = [{
    type             = "tcp"
    port             = 443
    use_existing_creds = false
    use_vault_creds    = false
  }]
}