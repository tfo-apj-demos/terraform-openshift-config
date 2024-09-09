locals {
pg_subscription = file("${path.module}/manifests/postgres-subscription.yaml")
pg_cluster = file("${path.module}/manifests/postgres-cluster.yaml")
redis_operatorgroup = file("${path.module}/manifests/redis-operatorgroup.yaml")
redis_subscription = file("${path.module}/manifests/redis-subscription.yaml")
redis_cluster = file("${path.module}/manifests/redis-cluster.yaml")

#ansible
aap_subscription = file("${path.module}/manifests/ansible-app-subscription.yaml")
aap_operatorgroup = file("${path.module}/manifests/ansible-operatorgroup.yaml")
aap_automationcontroller = file("${path.module}/manifests/aap-automationcontroller.yaml")
}