locals {
  mtv_operatorgroup = file("${path.module}/manifests/mtv/mtv-operatorgroup.yaml")
  mtv_subscription  = file("${path.module}/manifests/mtv/mtv-subscription.yaml")
}

resource "kubernetes_namespace" "mtv" {
  metadata {
    name = "openshift-mtv"
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


resource "kubernetes_manifest" "mtv_operatorgroup" {
  depends_on = [resource.kubernetes_namespace.mtv]
  manifest   = provider::kubernetes::manifest_decode(local.mtv_operatorgroup)
}

resource "kubernetes_manifest" "mtv_subscription" {
  depends_on = [resource.kubernetes_namespace.mtv]
  manifest   = provider::kubernetes::manifest_decode(local.mtv_subscription)
}
