
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}

resource kubernetes_namespace "vault" {
  metadata {
    name = "vault"
  }
}


resource "kubernetes_manifest" "vaultauth-sa" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vaultauth_sa)
}

resource "kubernetes_manifest" "vaultauth-clusterrole" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vaultauth_clusterrole)
}

resource "kubernetes_manifest" "vaultauth-rolebinding" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vaultauth_rolebinding)
}

resource "kubernetes_manifest" "vaultauth-secret" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vaultauth_secret)
}