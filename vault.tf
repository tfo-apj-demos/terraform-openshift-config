
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

resource "kubernetes_secret" "vault_auth_secret" {
  depends_on = [ kubernetes_namespace.vault ]
  metadata {
    name      = "vault-auth-secret"
    namespace = "vault"
    annotations = {
      "kubernetes.io/service-account.name" = "vault-auth"
    }
  }

  type = "kubernetes.io/service-account-token"
}

output "vault_auth_secret" {
  value = nonsensitive(kubernetes_secret.vault_auth_secret)
  sensitive = true
}