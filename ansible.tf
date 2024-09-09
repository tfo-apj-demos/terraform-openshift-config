resource "kubernetes_namespace" "aap" {
  metadata {
    name = "aap"
  }
}


resource "kubernetes_manifest" "aap-operatorgroup" {
depends_on = [ kubernetes_namespace.aap ]
  manifest = provider::kubernetes::manifest_decode(local.aap_operatorgroup)
}

resource "kubernetes_manifest" "aap-subscription" {
depends_on = [ kubernetes_namespace.aap ]
  manifest = provider::kubernetes::manifest_decode(local.aap_subscription)
}
