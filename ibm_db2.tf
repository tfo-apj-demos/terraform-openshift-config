locals {
  db2_catalog        = file("${path.module}/manifests/ibm-db2/db2-catalog.yaml")

}

resource "kubernetes_manifest" "db2_catalog" {
  for_each = local.db2_catalog
  manifest = yamldecode(each.value)
}