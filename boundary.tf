module "openshift_target" {
  source  = "app.terraform.io/tfo-apj-demos/target/boundary"
  version = "1.8.5"

  project_name           = "shared_services"
  hostname_prefix        = "On-Prem Openshift Console"

  hosts = [{
    hostname = "Openshift Console"
    address  = "https://console-openshift-console.apps.openshift-01.hashicorp.local/"
  }]

  services = [{
    type             = "tcp"
    name             = "Openshift Console"
    port             = 443
    credential_paths = []
  }]
} 