resource "kubernetes_namespace" "aap" {
  metadata {
    name = "aap"
  }

  lifecycle {
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
  depends_on = [kubernetes_namespace.aap]
  manifest   = provider::kubernetes::manifest_decode(local.aap_operatorgroup)
}

# Ansible AAP operator - Subscription
resource "kubernetes_manifest" "aap-subscription" {
  depends_on = [kubernetes_namespace.aap]
  manifest   = provider::kubernetes::manifest_decode(local.aap_subscription)
}