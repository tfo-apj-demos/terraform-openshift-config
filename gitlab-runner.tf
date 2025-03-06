resource "kubernetes_namespace" "gitlab-runner" {
  metadata {
    name = "gitlab-runner"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"],
      metadata.0.labels["olm.operatorgroup.uid/4a8b45e7-3b75-435a-9247-439bcfb63c1f"]
    ]
  }

}

# Subscription resource
resource "kubernetes_manifest" "gitlab_runner_operator_subscription" {
  manifest = provider::kubernetes::manifest_decode(local.gitlab_runner_subscription)
}

# OperatorGroup resource
# resource "kubernetes_manifest" "gitlab_runner_operatorgroup" {
#   manifest = provider::kubernetes::manifest_decode(local.gitlab_runner_operatorgroup)
# }
