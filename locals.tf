locals {
# TFE
pg_subscription = file("${path.module}/manifests/tfe/postgres-subscription.yaml")
pg_scc = file("${path.module}/manifests/tfe/postgres-scc.yaml")
pg_operatorgroup = file("${path.module}/manifests/tfe/postgres-operatorgroup.yaml")
pg_cluster = file("${path.module}/manifests/tfe/postgres-cluster.yaml")


# TFE S3 Bucket
tfe_s3bucket_tfeapp = file("${path.module}/manifests/tfe/s3bucket-tfeapp.yaml")

#ansibl automation platform operator
aap_subscription = file("${path.module}/manifests/ansible/ansible-app-subscription.yaml")
aap_operatorgroup = file("${path.module}/manifests/ansible/ansible-operatorgroup.yaml")

# Ansible Automation Platform
aap_controller = file("${path.module}/manifests/ansible/aap-controller.yaml")
aap_hub= file("${path.module}/manifests/ansible/aap-hub.yaml")
aap_eda = file("${path.module}/manifests/ansible/aap-eda.yaml")

# AWX
awx = file("${path.module}/manifests/awx/kustomization-awx.yaml")

# EDA
eda = file("${path.module}/manifests/eda/kustomization-eda.yaml")

# Vault
vault_operator = file("${path.module}/manifests/vault/vault-operator-subscription.yaml")
vaultauth_sa = file("${path.module}/manifests/vault/vaultauth-sa.yaml")
vaultauth_clusterrole = file("${path.module}/manifests/vault/vaultauth-clusterrole.yaml")
vaultauth_rolebinding = file("${path.module}/manifests/vault/vaultauth-rolebinding.yaml")

vault_connection = file("${path.module}/manifests/vault/crd-vault-connection.yaml")
vault_auth = file("${path.module}/manifests/vault/crd-vault-auth.yaml")
#tfe cert
tfe_pkicert = file("${path.module}/manifests/vault/crd-pki-tfecert.yaml")
}