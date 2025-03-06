resource "kubernetes_namespace" "awx" {
  metadata {
    name = "awx"
  }
  lifecycle {
    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"]
    ]
  }
}

# AWX
/*resource "kubernetes_manifest" "awx" {
    depends_on = [ kubernetes_namespace.awx ]
  manifest = provider::kubernetes::manifest_decode(local.awx)
}*/

locals {
  awx_helm_values = file("${path.module}/templates/awx_helm_values.yaml")
}

# deploy tfe using helm chart
resource "helm_release" "awx" {
  name             = "awx-operator"
  repository       = "https://ansible-community.github.io/awx-operator-helm"
  chart            = "awx-operator"
  version          = "1.3.0"
  create_namespace = false
  namespace        = kubernetes_namespace.awx.metadata[0].name
  wait             = false
  force_update     = true

  values = [
    local.awx_helm_values
  ]

}