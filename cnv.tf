locals {
  cnv_operatorgroup = file("${path.module}/manifests/cnv/cnv-operatorgroup.yaml")
  cnv_subscription  = file("${path.module}/manifests/cnv/cnv-subscription.yaml")
}

resource "kubernetes_namespace" "cnv" {
  metadata {
    name = "openshift-cnv"
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


resource "kubernetes_manifest" "cnv_operatorgroup" {
  depends_on = [resource.kubernetes_namespace.cnv]
  manifest   = provider::kubernetes::manifest_decode(local.cnv_operatorgroup)
}

resource "kubernetes_manifest" "cnv_subscription" {
  depends_on = [resource.kubernetes_namespace.cnv]
  manifest   = provider::kubernetes::manifest_decode(local.cnv_subscription)
}
