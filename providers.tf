
provider "kubernetes" {
  # Configuration options
  host                   = var.host
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  client_key             = base64decode(var.client_key)
  client_certificate     = base64decode(var.client_certificate)

}

provider "helm" {
  # Configuration options
  kubernetes {
    host                   = var.host
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    client_key             = base64decode(var.client_key)
    client_certificate     = base64decode(var.client_certificate)
  }
}

provider "boundary" {
  addr                   = var.boundary_address
  auth_method_id         = var.service_account_authmethod_id
  auth_method_login_name = var.service_account_name
  auth_method_password   = var.service_account_password
}
