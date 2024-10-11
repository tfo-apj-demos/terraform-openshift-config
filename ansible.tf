resource "kubernetes_namespace" "aap" {
  metadata {
    name = "aap"
  }
  
  lifecycle{
    ignore_changes = [
        metadata.0.annotations["openshift.io/sa.scc.mcs"],
        metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
        metadata.0.annotations["openshift.io/sa.scc.uid-range"],
        metadata.0.labels["olm.operatorgroup.uid/4a8b45e7-3b75-435a-9247-439bcfb63c1f"]
    ]
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

# Ansible Controller resource
resource "kubernetes_manifest" "aap-controller" {
depends_on = [ kubernetes_manifest.aap-subscription ]
  manifest = provider::kubernetes::manifest_decode(local.aap_controller)
}

# Ansible EDA resource
# resource "kubernetes_manifest" "aap-eda" {
# depends_on = [ kubernetes_manifest.aap-subscription ]
#   manifest = provider::kubernetes::manifest_decode(local.aap_eda)
# }

removed {
  from = kubernetes_manifest.aap-eda

  lifecycle {
    destroy = false
  }
}


# Ansible Automation Hub
# resource "kubernetes_manifest" "aap-hub" {
# depends_on = [ kubernetes_manifest.aap-subscription ]
#   manifest = provider::kubernetes::manifest_decode(local.aap_hub)
# }

removed {
  from = kubernetes_manifest.aap-hub

  lifecycle {
    destroy = false
  }
}
