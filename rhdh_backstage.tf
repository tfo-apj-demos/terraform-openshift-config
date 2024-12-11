locals {
  rhdh_operator_group = file("${path.module}/manifests/backstage/rhdh-operatorgroup.yaml")
  rhdh_operator_subscription = file("${path.module}/manifests/backstage/rhdh-subscription.yaml")
}


resource "kubernetes_namespace" "rhdh_operator" {
  metadata {
    name = "rhdh-operator"
  }

  lifecycle{
    ignore_changes = [
        metadata.0.annotations["openshift.io/sa.scc.mcs"],
        metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
        metadata.0.annotations["openshift.io/sa.scc.uid-range"],
        metadata.0.labels["olm.operatorgroup.uid/78dff708-1437-40e8-90af-eccf84e06ae7"],
    ]
  }
}


resource "kubernetes_manifest" "rhdh_operator_group" {
  depends_on = [ kubernetes_namespace.rhdh_operator ]
  manifest = provider::kubernetes::manifest_decode(local.rhdh_operator_group)
}

resource "kubernetes_manifest" "rhdh_subscription" {
  depends_on = [ kubernetes_namespace.rhdh_operator ]
  manifest = provider::kubernetes::manifest_decode(local.rhdh_operator_subscription)
}