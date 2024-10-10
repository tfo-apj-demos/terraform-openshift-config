resource "kubernetes_namespace" "awx" {
  metadata {
    name = "awx"
  }  
}

# AWX
resource "kubernetes_manifest" "awx" {
    depends_on = [ kubernetes_namespace.awx ]
  manifest = provider::kubernetes::manifest_decode(local.awx)
}