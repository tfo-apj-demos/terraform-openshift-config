
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

# resource "kubernetes_namespace" "tfe-agents" {
#   metadata {
#     name = "tfe-agents"
#   }

#   lifecycle{
#     ignore_changes = [
#         metadata.0.annotations["openshift.io/sa.scc.mcs"],
#         metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
#         metadata.0.annotations["openshift.io/sa.scc.uid-range"]
#     ]
#   }
# }


resource "kubernetes_manifest" "pg-operator" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.pg_subscription)
}

# resource "kubernetes_manifest" "pg-scc" {
#   depends_on = [ kubernetes_namespace.tfe ]
#   manifest = provider::kubernetes::manifest_decode(local.pg_scc)
# }




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

resource "kubernetes_manifest" "redis-db" {
  depends_on = [ kubernetes_manifest.redis-operator ]

  manifest = provider::kubernetes::manifest_decode(local.redis_db)
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
          username = "terraform"
          password = var.tfe_license
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
  chart      = "terraform-enterprise"
  version    = "1.3.2"
  create_namespace = false
  namespace = "tfe"
  wait = false

  values = [
    local.tfe_helm_values
  ]

}

resource "kubernetes_secret" "operator" {
  metadata {
    name      = "hcp-terraform-operator"
    namespace = "tfe"
  }

  data = {
    token = "dummy"#to be updated
  }
}

# Terraform Cloud Operator for K8s helm chart
resource "helm_release" "operator" {
  depends_on = [ kubernetes_namespace.tfe ]
  name       = "hcp-terraform-operator"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "hcp-terraform-operator"
  version    = "2.6.1"
  namespace  = "tfe"

}
