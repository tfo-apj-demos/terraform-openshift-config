resource "kubernetes_namespace" "aap" {
  metadata {
    name = "aap"
  }
}

# Ansible AAP operator - OperatorGroup
resource "kubernetes_manifest" "aap-operatorgroup" {
depends_on = [ kubernetes_namespace.aap ]
  manifest = provider::kubernetes::manifest_decode(local.aap_operatorgroup)
}

# Ansible AAP operator - Subscription
resource "kubernetes_manifest" "aap-subscription" {
depends_on = [ kubernetes_namespace.aap ]
  manifest = provider::kubernetes::manifest_decode(local.aap_subscription)
}

# # Ansible Controller resource
# resource "kubernetes_manifest" "aap-controller" {
# depends_on = [ kubernetes_manifest.aap-subscription ]
#   manifest = provider::kubernetes::manifest_decode(local.aap_controller)
# }

# # Ansible EDA resource
# resource "kubernetes_manifest" "aap-eda" {
# depends_on = [ kubernetes_manifest.aap-subscription ]
#   manifest = provider::kubernetes::manifest_decode(local.aap_eda)
# }


# # Ansible Automation Hub
# resource "kubernetes_manifest" "aap-hub" {
# depends_on = [ kubernetes_manifest.aap-subscription ]
#   manifest = provider::kubernetes::manifest_decode(local.aap_hub)
# }