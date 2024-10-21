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
resource "kubernetes_manifest" "eda" {
    depends_on = [ kubernetes_namespace.eda ]
  manifest = provider::kubernetes::manifest_decode_multi(local.eda)
}
