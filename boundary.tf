module "openshift_target" {
  source  = "github.com/tfo-apj-demos/terraform-boundary-target-refactored"

  project_name           = "shared_services"
  hostname_prefix        = "On-Prem Openshift Console"

  hosts = [{
    hostname = "Openshift Console"
    address  = "console-openshift-console.apps.openshift-01.hashicorp.local"
  }]

  services = [{
    type             = "tcp"
    port             = 443
    use_existing_creds = false
    use_vault_creds    = false
  }]
}