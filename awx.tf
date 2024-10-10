resource "kubernetes_namespace" "awx" {
  metadata {
    name = "awx"
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
  name       = "awx-operator"
  repository = "https://ansible-community.github.io/awx-operator-helm/"
  chart      = "awx-operator/awx-operator"
  version    = "~> 2"
  create_namespace = false
  namespace = kubernetes_namespace.awx.metadata[0].name
  wait = false
  force_update = true

  values = [
    local.awx_helm_values
  ]

}