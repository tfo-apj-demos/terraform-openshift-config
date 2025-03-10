locals {
 #keycloak subscription
 keycloak_subscription = file("${path.module}/manifests/keycloak/keycloak-subscription.yaml") 
 keycloak_operatorgroup = file("${path.module}/manifests/keycloak/keycloak-operatorgroup.yaml")
}