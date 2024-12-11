locals {  
  gitlab_operatorgroup = file("${path.module}/manifests/gitlab/gitlab-operatorgroup.yaml")
  gitlab_subscription = file("${path.module}/manifests/gitlab/gitlab-subscription.yaml")
}

resource "kubernetes_namespace" "gitlab" {
  metadata {
    name = "gitlab"
  }

    lifecycle {
    
    ignore_changes = [
        metadata.0.annotations["openshift.io/sa.scc.mcs"],
        metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
        metadata.0.annotations["openshift.io/sa.scc.uid-range"],
        metadata.0.labels
    ]
    }
}


resource "kubernetes_manifest" "gitlab_subscription" {
  depends_on = [ resource.kubernetes_namespace.gitlab ]
  manifest = provider::kubernetes::manifest_decode(local.gitlab_subscription)
}

# Subscription resource
resource "kubernetes_manifest" "gitlab_operatorgroup" {
  depends_on = [ resource.kubernetes_namespace.gitlab ]
  manifest = provider::kubernetes::manifest_decode(local.gitlab_operatorgroup)
}