
resource "kubernetes_manifest" "vault-operator" {
  manifest = provider::kubernetes::manifest_decode(local.vault_operator)
}

resource kubernetes_namespace "vault" {
  metadata {
    name = "vault"
  }
  
  lifecycle{
    ignore_changes = [
        metadata.0.annotations["openshift.io/sa.scc.mcs"],
        metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
        metadata.0.annotations["openshift.io/sa.scc.uid-range"]
    ]
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


resource "kubernetes_manifest" "vault-connection" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vault_connection)
}

resource "kubernetes_manifest" "vault-auth-crd" {
  depends_on = [ kubernetes_namespace.vault ]
  manifest = provider::kubernetes::manifest_decode(local.vault_auth)
}


resource "kubernetes_manifest" "pki-tfe-crd" {
  manifest = provider::kubernetes::manifest_decode(local.tfe_pkicert)
}


resource "kubernetes_secret" "pki-tfecert" {

  metadata {
    name      = "tfe-certificate"
    namespace = "tfe"
  }