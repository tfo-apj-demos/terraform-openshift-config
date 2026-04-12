# --- OpenShift OAuth configuration with HCP Vault OIDC provider

resource "kubernetes_secret" "oidc_client_secret" {
  metadata {
    name      = "hcp-vault-oidc-client-secret"
    namespace = "openshift-config"
  }

  data = {
    clientSecret = var.oidc_client_secret
  }
}

resource "kubernetes_manifest" "oauth_cluster" {
  manifest = {
    apiVersion = "config.openshift.io/v1"
    kind       = "OAuth"
    metadata = {
      name = "cluster"
    }
    spec = {
      identityProviders = [
        {
          name          = "hcp-vault"
          mappingMethod = "claim"
          type          = "OpenID"
          openID = {
            clientID = var.oidc_client_id
            clientSecret = {
              name = kubernetes_secret.oidc_client_secret.metadata[0].name
            }
            issuer = "https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200/v1/admin/tfo-apj-demos/identity/oidc/provider/team_se"
            claims = {
              preferredUsername = ["username"]
              name              = ["username"]
              groups            = ["groups"]
            }
            extraScopes = ["username", "groups"]
          }
        }
      ]
    }
  }
}

# --- RBAC: team-se group gets cluster-wide view access
resource "kubernetes_cluster_role_binding" "team_se_view" {
  metadata {
    name = "oidc-team-se-view"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = "team-se"
  }
}

# --- RBAC: gcve-admins group gets cluster-admin access
resource "kubernetes_cluster_role_binding" "gcve_admins_cluster_admin" {
  metadata {
    name = "oidc-gcve-admins-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = "gcve-admins"
  }
}
