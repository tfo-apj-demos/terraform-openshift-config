
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
        metadata.0.labels["olm.operatorgroup.uid/78dff708-1437-40e8-90af-eccf84e06ae7"],
    ]
  }
}


resource "kubernetes_manifest" "pg-operator" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.pg_subscription)
}



resource "kubernetes_manifest" "postgres-operatorgroup" {
  depends_on = [ kubernetes_namespace.tfe ]
  manifest = provider::kubernetes::manifest_decode(local.pg_operatorgroup)
}



resource "kubernetes_manifest" "pg-cluster" {
  depends_on = [ kubernetes_manifest.pg-operator ]
  manifest = provider::kubernetes::manifest_decode(local.pg_cluster)
  
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

removed {
  from = helm_release.tfe

  lifecycle {
    destroy = false
  }
}


resource "kubernetes_secret" "operator" {
  metadata {
    name      = "hcp-terraform-operator"
    namespace = "tfe"
  }

  data = {
    token = var.hcp_operator_token
  }
}

# Terraform Cloud Operator for K8s helm chart
resource "helm_release" "operator1" {
  depends_on = [ kubernetes_namespace.tfe ]
  name       = "hcp-terraform-operator"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "hcp-terraform-operator"
  version    = "2.8.0"
  namespace  = "tfe"
  # add values tfeAddress
  values = [
    jsonencode({
      tfeAddress = "tfe.hashicorp.local"
    })
  ]
}
