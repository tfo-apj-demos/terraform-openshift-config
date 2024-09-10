data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
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

resource "kubernetes_manifest" "pg-cluster" {
  manifest = provider::kubernetes::manifest_decode(local.pg_cluster)
}


resource "kubernetes_manifest" "redis-operatorgroup" {
  manifest = provider::kubernetes::manifest_decode(local.redis_operatorgroup)
}

resource "kubernetes_manifest" "redis-operator" {
  manifest = provider::kubernetes::manifest_decode(local.redis_subscription)
}

resource "kubernetes_manifest" "redis-cluster" {
  manifest = provider::kubernetes::manifest_decode(local.redis_cluster)
  field_manager {
    froforce_conflicts = true
  }
}







# apiVersion: v1
# kind: Secret
# metadata:
#   name: tfe-pguser-tfeadmin
#   labels:
#     postgres-operator.crunchydata.com/cluster: tfe
#     postgres-operator.crunchydata.com/pguser: tfeadmin
# stringData:
#   password: "${var.pg_password}"