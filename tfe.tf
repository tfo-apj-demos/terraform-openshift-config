
# create kubernetes namespace
resource "kubernetes_namespace" "tfe" {
  metadata {
    name = "tfe"
  }

  lifecycle{
    ignore_changes = [
        metadata.0.annotations[openshift.io/sa.scc.mcs],
        metadata.0.annotations[openshift.io/sa.scc.supplemental-groups],
        metadata.0.annotations[openshift.io/sa.scc.uid-range]
    ]
  }
}

resource "kubernetes_namespace" "tfe-agents" {
  metadata {
    name = "tfe-agents"
  }

  lifecycle{
    ignore_changes = [
        metadata.0.annotations[openshift.io/sa.scc.mcs],
        metadata.0.annotations[openshift.io/sa.scc.supplemental-groups],
        metadata.0.annotations[openshift.io/sa.scc.uid-range]
    ]
  }
}


resource "kubernetes_manifest" "pg-operator" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.pg_subscription)
}




resource "kubernetes_manifest" "redis-operatorgroup" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.redis_operatorgroup)
}

resource "kubernetes_manifest" "redis-operator" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.redis_subscription)
}

#security context constraint
resource "kubernetes_manifest" "redis-scc" {
  manifest = provider::kubernetes::manifest_decode(local.redis_scc)
}


resource "kubernetes_manifest" "pg-cluster" {
  depends_on = [ kubernetes_manifest.pg-operator ]
  manifest = provider::kubernetes::manifest_decode(local.pg_cluster)
  
}

resource "kubernetes_manifest" "redis-cluster" {
  depends_on = [ kubernetes_manifest.redis-operator ]

  manifest = provider::kubernetes::manifest_decode(local.redis_cluster)
  field_manager {
    force_conflicts = true
  }
}



resource "kubernetes_manifest" "s3bucket-tfeapp" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.tfe_s3bucket_tfeapp)
}