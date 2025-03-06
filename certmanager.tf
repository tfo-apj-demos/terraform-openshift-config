locals {
  certmanager_operatorgroup = file("${path.module}/manifests/cert-manager/certmanager-operatorgroup.yaml")
  certmanager_subscription  = file("${path.module}/manifests/cert-manager/certmanager-subscription.yaml")
}

resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager-operator"
  }

  lifecycle {

    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"],
      metadata.0.labels
    ]
  }
}


resource "kubernetes_manifest" "certmanager_subscription" {
  depends_on = [resource.kubernetes_namespace.certmanager]
  manifest   = provider::kubernetes::manifest_decode(local.certmanager_subscription)
}

# Subscription resource
resource "kubernetes_manifest" "certmanager_operatorgroup" {
  depends_on = [resource.kubernetes_namespace.certmanager]
  manifest   = provider::kubernetes::manifest_decode(local.certmanager_operatorgroup)
}