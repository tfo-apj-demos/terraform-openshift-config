locals {
# TFE
pg_subscription = file("${path.module}/manifests/tfe/postgres-subscription.yaml")
pg_cluster = file("${path.module}/manifests/tfe/postgres-cluster.yaml")
redis_operatorgroup = file("${path.module}/manifests/tfe/redis-operatorgroup.yaml")
redis_subscription = file("${path.module}/manifests/tde/redis-subscription.yaml")
redis_cluster = file("${path.module}/manifests/tfe/redis-cluster.yaml")

#ansibl automation platform operator
aap_subscription = file("${path.module}/manifests/ansible/ansible-app-subscription.yaml")
aap_operatorgroup = file("${path.module}/manifests/ansible/ansible-operatorgroup.yaml")

# Ansible Automation Platform
aap_controller = file("${path.module}/manifests/ansible/aap-controller.yaml")
aap_hub= file("${path.module}/manifests/ansible/aap-hub.yaml")
aap_eda = file("${path.module}/manifests/ansible/aap-eda.yaml")
}