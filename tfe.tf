
# create kubernetes namespace
resource "kubernetes_namespace" "tfe" {
  metadata {
    name = "tfe"
  }

  lifecycle{
    ignore_changes = [
        metadata.0.annotations["openshift.io/sa.scc.mcs"],
        metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
        metadata.0.annotations["openshift.io/sa.scc.uid-range"],
        metadata.0.labels["olm.operatorgroup.uid/acd7ea75-3a17-44aa-9c11-3518b946e6f7"],
    ]
  }
}

resource "kubernetes_namespace" "tfe-agents" {
  metadata {
    name = "tfe-agents"
  }

  lifecycle{
    ignore_changes = [
        metadata.0.annotations["openshift.io/sa.scc.mcs"],
        metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
        metadata.0.annotations["openshift.io/sa.scc.uid-range"]
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

resource "kubernetes_secret" "terraform_enterprise" {
  metadata {
    name      = "terraform-enterprise"
    namespace = "tfe"
  }
  
  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "images.releases.hashicorp.com" = {
          auth = base64encode("terraform:${var.tfe_license}")
        }
      }
    })
  }
}

# deploy tfe using helm chart
resource "helm_release" "tfe" {
  name       = "terraform-enterprise"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "terraform-enterprise-helm"
  version    = "v1.3.2"
  create_namespace = false
  namespace = "tfe"

  values = [
    "${local.tfe_helm_values}"
  ]

}