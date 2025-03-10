# oc get packagemanifests rhbk-operator -o yaml
locals {
 #keycloak subscription
 keycloak_subscription = file("${path.module}/manifests/keycloak/keycloak-subscription.yaml") 
 keycloak_operatorgroup = file("${path.module}/manifests/keycloak/keycloak-operatorgroup.yaml")
}

resource "kubernetes_namespace" "keycloak" {
  metadata {
    name = "keycloak"
  }
}

#kubenetes manifest subscription
resource "kubernetes_manifest" "keycloak_subscription" {
  depends_on = [ kubernetes_namespace.keycloak ]
  manifest = provider::kubernetes::manifest_decode(local.keycloak_subscription)
}
#kubenetes manifest operatorgroup
resource "kubernetes_manifest" "keycloak_operatorgroup" {
  depends_on = [ kubernetes_namespace.keycloak ]
  manifest = provider::kubernetes::manifest_decode(local.keycloak_operatorgroup)
}