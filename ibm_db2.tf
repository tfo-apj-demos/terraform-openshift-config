locals {
  db2_catalog        = file("${path.module}/manifests/ibm-db2/db2-catalog.yaml")

}

resource "kubernetes_manifest" "db2_catalog" {
  manifest = provider::kubernetes::manifest_decode(local.db2_catalog)
}