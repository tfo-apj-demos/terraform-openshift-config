
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"]
    ]
  }

}


resource "kubernetes_manifest" "vaultauth-sa" {
  depends_on = [kubernetes_namespace.vault]
  manifest   = provider::kubernetes::manifest_decode(local.vaultauth_sa)
}

resource "kubernetes_manifest" "vaultauth-clusterrole" {
  depends_on = [kubernetes_namespace.vault]
  manifest   = provider::kubernetes::manifest_decode(local.vaultauth_clusterrole)
}

resource "kubernetes_manifest" "vaultauth-rolebinding" {
  depends_on = [kubernetes_namespace.vault]
  manifest   = provider::kubernetes::manifest_decode(local.vaultauth_rolebinding)
}

resource "kubernetes_secret" "vault_auth_secret" {
  depends_on = [kubernetes_namespace.vault]
  metadata {
    name      = "vault-auth-secret"
    namespace = "tfe"
    annotations = {
      "kubernetes.io/service-account.name" = "vault-auth"
    }
  }

  type = "kubernetes.io/service-account-token"
}


# Lab CA (HCP Vault Issuing -> Central Signing -> Root, verified against Vault's
# live leaf) so the VaultConnection can verify Vault's TLS instead of skipping it.
resource "kubernetes_secret" "tfe-vault-ca" {
  metadata {
    name      = "vault-ca"
    namespace = "tfe"
  }
  data = {
    "ca.crt" = file("${path.module}/manifests/vault/vault-ca.pem")
  }
}

resource "kubernetes_manifest" "vault-connection" {
  depends_on = [kubernetes_namespace.vault, kubernetes_secret.tfe-vault-ca]
  manifest   = provider::kubernetes::manifest_decode(local.vault_connection)
}

resource "kubernetes_manifest" "vault-auth-crd" {
  depends_on = [kubernetes_namespace.vault]
  manifest   = provider::kubernetes::manifest_decode(local.vault_auth)
}


resource "kubernetes_manifest" "pki-tfe-crd" {
  manifest = provider::kubernetes::manifest_decode(local.tfe_pkicert)
}
