locals {
  ibm_catalog       = file("${path.module}/manifests/ibm-db2/ibm-catalog.yaml")
  db2_operatorgroup = file("${path.module}/manifests/ibm-db2/db2-operatorgroup.yaml")
  db2_subscription  = file("${path.module}/manifests/ibm-db2/db2-subscription.yaml")

}

resource "kubernetes_namespace" "db2" {
  metadata {
    name = "db2"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"],
      metadata.0.labels["olm.operatorgroup.uid/46b7a13f-e405-417b-b4fb-0cbfe8de61aa"]
    ]
  }
  
}

resource "kubernetes_manifest" "db2_catalog" {
  manifest = provider::kubernetes::manifest_decode(local.ibm_catalog)
}


resource "kubernetes_manifest" "db2_operatorgroup" {
  depends_on = [kubernetes_namespace.db2]
  manifest   = provider::kubernetes::manifest_decode(local.db2_operatorgroup)
}

resource "kubernetes_manifest" "db2_subscription" {
  depends_on = [kubernetes_namespace.db2]
  manifest   = provider::kubernetes::manifest_decode(local.db2_subscription)
}