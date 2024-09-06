data "kubernetes_all_namespaces" "allns" {}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}


locals {
  manifest = <<EOT
---
kind: Namespace
apiVersion: v1
metadata:
  name: postgres-operator
EOT
}



resource "kubernetes_manifest" "namespace" {
  manifest = provider::kubernetes::manifest_decode(local.manifest)
}