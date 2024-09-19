
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}

resource kubernetes_namespace "vault" {
  metadata {
    name = "vault"
  }
}


# resource "kubernetes_manifest" "auth_prereqs" {
#   depends_on = [ kubernetes_namespace.vault ]

#   manifest = provider::kubernetes::manifest_decode_multi(local.vault_auth_prereqs)
# }


output "auth_prereqs" {
  value = provider::kubernetes::manifest_decode_multi(local.vault_auth_prereqs)
# }
}