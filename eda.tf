# resource "kubernetes_namespace" "eda" {
#   metadata {
#     name = "eda"
#   }  
#   lifecycle{
#     ignore_changes = [
#         metadata.0.annotations["openshift.io/sa.scc.mcs"],
#         metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
#         metadata.0.annotations["openshift.io/sa.scc.uid-range"]
#     ]
#   }
# }

# AWX


# locals {
#   eda_manifests = provider::kubernetes::manifest_decode_multi(local.eda)
# }

# resource "kubernetes_manifest" "eda-namespace" {
#   manifest = provider::kubernetes::manifest_decode(local.eda_namespace)
# }



# resource "kubernetes_manifest" "eda" {
#   depends_on = [ kubernetes_manifest.eda-namespace ]

#   for_each = {
#     for manifest in local.eda_manifests :
#     "${manifest.kind}-${manifest.metadata.name}" => manifest
#   }

#   manifest = each.value
# }
