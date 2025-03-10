locals {
  ibm_catalog        = file("${path.module}/manifests/ibm-db2/ibm-catalog.yaml")

}

resource "kubernetes_manifest" "db2_catalog" {
  manifest = provider::kubernetes::manifest_decode(local.ibm_catalog)
}