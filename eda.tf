locals {
  eda_manifests = provider::kubernetes::manifest_decode_multi(local.eda)
}

resource "kubernetes_manifest" "eda-namespace" {
  manifest = provider::kubernetes::manifest_decode(local.eda_namespace)
}

resource "kubernetes_manifest" "eda" {
  depends_on = [ kubernetes_manifest.eda-namespace ]

  for_each = {
    for manifest in local.eda_manifests :
    "${manifest.kind}-${manifest.metadata.name}" => manifest
  }

  manifest = each.value
}
