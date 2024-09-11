
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
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.pg_subscription)
}

# resource "kubernetes_manifest" "pg-cluster" {
#   depends_on = [ kubernetes_manifest.pg-operator ]
#   manifest = provider::kubernetes::manifest_decode(local.pg_cluster)
  
# }


resource "kubernetes_manifest" "redis-operatorgroup" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.redis_operatorgroup)
}

resource "kubernetes_manifest" "redis-operator" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.redis_subscription)
}

# resource "kubernetes_manifest" "redis-cluster" {
#   depends_on = [ kubernetes_manifest.redis-operator ]

#   manifest = provider::kubernetes::manifest_decode(local.redis_cluster)
#   field_manager {
#     force_conflicts = true
#   }
# }

