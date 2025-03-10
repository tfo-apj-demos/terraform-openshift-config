locals {
  ibm_catalog        = file("${path.module}/manifests/ibm-db2/ibm-catalog.yaml")
  db2_operatorgroup  = file("${path.module}/manifests/ibm-db2/db2-operatorgroup.yaml")
  db2_subscription   = file("${path.module}/manifests/ibm-db2/db2-subscription.yaml")

}

resource "kubernetes_namespace" "db2u" {
  metadata {
    name = "db2"
  }
}

resource "kubernetes_manifest" "db2_catalog" {
  manifest = provider::kubernetes::manifest_decode(local.ibm_catalog)
}


resource "kubernetes_manifest" "db2_operatorgroup" {
  depends_on = [ kubernetes_namespace.db2u ]
  manifest = provider::kubernetes::manifest_decode(local.db2_operatorgroup)
}

resource "kubernetes_manifest" "db2_subscription" {
  depends_on = [ kubernetes_namespace.db2u ]
  manifest = provider::kubernetes::manifest_decode(local.db2_subscription)
}