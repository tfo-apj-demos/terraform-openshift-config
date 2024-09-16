
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}