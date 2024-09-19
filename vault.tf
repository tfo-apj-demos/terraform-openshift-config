
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}


resource "kubernetes_manifest" "auth_prereqs" {
  manifest = provider::kubernetes::manifest_decode_multi(local.vault_auth_prereqs)
}