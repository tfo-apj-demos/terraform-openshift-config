locals {
# TFE
pg_subscription = file("${path.module}/manifests/tfe/postgres-subscription.yaml")
pg_cluster = file("${path.module}/manifests/tfe/postgres-cluster.yaml")
redis_operatorgroup = file("${path.module}/manifests/tfe/redis-operatorgroup.yaml")
redis_subscription = file("${path.module}/manifests/tde/redis-subscription.yaml")
redis_cluster = file("${path.module}/manifests/tfe/redis-cluster.yaml")

#ansible
aap_subscription = file("${path.module}/manifests/ansible/ansible-app-subscription.yaml")
aap_operatorgroup = file("${path.module}/manifests/ansible/ansible-operatorgroup.yaml")
aap_automationcontroller = file("${path.module}/manifests/ansible/aap-automationcontroller.yaml")
aap_eda = file("${path.module}/manifests/ansible/aap-eda.yaml")
}