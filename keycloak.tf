locals {
 #keycloak subscription
 keycloak_subscription = file("${path.module}/manifests/keycloak/keycloak_subscription.yaml") 
 keycloak_operatorgroup = file("${path.module}/manifests/keycloak/keycloak_operatorgroup.yaml")
}