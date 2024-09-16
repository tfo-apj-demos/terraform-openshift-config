resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "kubernetes_manifest" "vault-operator" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}