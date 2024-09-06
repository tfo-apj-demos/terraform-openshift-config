data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}


locals {

pg_subscription = file("${path.module}/manifests/postgres-subscription.yaml")

}

# create kubernetes namespace
resource "kubernetes_namespace" "pg-operator" {
  metadata {
    name = "postgres-operator"
  }
}

resource "kubernetes_manifest" "pg-operator" {
  depends_on = [resource.kubernetes_namespace.pg-operator]
  manifest = provider::kubernetes::manifest_decode(local.pg_subscription)
}

