locals {
# TFE
pg_subscription = file("${path.module}/manifests/tfe/postgres-subscription.yaml")
pg_cluster = file("${path.module}/manifests/tfe/postgres-cluster.yaml")
redis_operatorgroup = file("${path.module}/manifests/tfe/redis-operatorgroup.yaml")
redis_subscription = file("${path.module}/manifests/tfe/redis-subscription.yaml")
redis_scc = file("${path.module}/manifests/tfe/redis-scc.yaml")
redis_cluster = file("${path.module}/manifests/tfe/redis-cluster.yaml")

# TFE S3 Bucket
tfe_s3bucket_tfeapp = file("${path.module}/manifests/tfe/s3bucket-tfeapp.yaml")

#ansibl automation platform operator
aap_subscription = file("${path.module}/manifests/ansible/ansible-app-subscription.yaml")
aap_operatorgroup = file("${path.module}/manifests/ansible/ansible-operatorgroup.yaml")

# Ansible Automation Platform
aap_controller = file("${path.module}/manifests/ansible/aap-controller.yaml")
aap_hub= file("${path.module}/manifests/ansible/aap-hub.yaml")
aap_eda = file("${path.module}/manifests/ansible/aap-eda.yaml")


# Vault
vault_operator = file("${path.module}/manifests/vault/vault-operator-subscription.yaml")
vault_auth_prereqs = file("${path.module}/manifests/vault/vault-auth-prereqs.yaml")
}