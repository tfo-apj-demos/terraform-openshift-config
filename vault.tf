
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}

resource kubernetes_namespace "vault" {
  metadata {
    name = "vault"
  }
}


resource "kubernetes_manifest" "resources" {
  depends_on = [ kubernetes_namespace.vault ]
  for_each = { for manifest in provider::kubernetes::manifest_decode_multi(local.vault_auth_prereqs) : "${manifest.kind}/${manifest.metadata.namespace}/${manifest.metadata.name}" => manifest}

  manifest = each.value
}
