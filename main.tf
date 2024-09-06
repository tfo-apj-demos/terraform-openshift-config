data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}


locals {

pg_subscription = file("${path.module}/manifests/postgres-subscription.yaml")

}

# create kubernetes namespace
resource "kubernetes_namespace" "tfe" {
  metadata {
    name = "tfe"
  }
}

resource "kubernetes_namespace" "tfe-agents" {
  metadata {
    name = "tfe-agents"
  }
}


resource "kubernetes_manifest" "pg-operator" {
  manifest = provider::kubernetes::manifest_decode(local.pg_subscription)
}

