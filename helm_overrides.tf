locals {
  helm_overrides_values = {
    # TFE image settings
    tfe_replica_count       = 1
    tfe_image_repository_url = "images.releases.hashicorp.com"
    tfe_image_name           = "hashicorp/terraform-enterprise"
    tfe_image_tag            = "v202409-1"

    # TFE config settings
    tfe_hostname = "tfe.hashicorp.local"

    # Database settings
    tfe_database_host       = "${data.kubernetes_secret.postgres.data.host}:${data.kubernetes_secret.postgres.data.port}"
    tfe_database_name       = "${data.kubernetes_secret.postgres.data.user}"
    tfe_database_user       = "${data.kubernetes_secret.postgres.data.dbname}"
    tfe_database_parameters = "sslmode=disable"
    # Object storage settings
    tfe_object_storage_type                                 = "s3"
    tfe_object_storage_s3_bucket                            = "${data.kubernetes_resource.s3.object.spec.bucketName}"
    tfe_object_storage_s3_region                            = "us-east-1"
    tfe_object_storage_s3_endpoint                          = "rook-ceph-rgw-ocs-storagecluster-cephobjectstore.openshift-storage.svc:443"
    tfe_object_storage_s3_use_instance_profile              = false
    tfe_object_storage_s3_access_key_id                     = "${data.kubernetes_secret.s3.data.AWS_ACCESS_KEY_ID}"
    tfe_object_storage_s3_secret_access_key                 = "${data.kubernetes_secret.s3.data.AWS_SECRET_ACCESS_KEY}"
    tfe_object_storage_s3_server_side_encryption            = ""

    # Redis settings
    tfe_redis_host     = "redb.tfe.svc.cluster.local:12672"
    tfe_redis_use_auth = true
    tfe_redis_use_tls  = false
  }

  tfe_helm_values = templatefile("${path.module}/templates/helm_overrides_values.yaml.tpl", local.helm_overrides_values)
}

data "kubernetes_secret" "s3" {
  metadata {
    name = "tfeapp"
    namespace = "tfe"
  }
}


data "kubernetes_resource" "s3" {
  api_version = "objectbucket.io/v1alpha1"
  kind        = "ObjectBucketClaim"

  metadata {
    name      = "tfeapp"
    namespace = "tfe"
  }
}


data "kubernetes_secret" "postgres" {
  metadata {
    name = "tfedb-pguser-tfeadmin"
    namespace = "tfe"
  }
}

data "kubernetes_secret" "redis" {
  metadata {
    name = "redb-redb"
    namespace = "tfe"
  }
}

resource "kubernetes_secret" "tfe-secrets" {
  metadata {
    name = "tfe-secrets"
    namespace = "tfe"
  }

  data = {
    TFE_LICENSE: var.tfe_license
    TFE_ENCRYPTION_PASSWORD: var.tfe_encryption_password
    TFE_DATABASE_PASSWORD: data.kubernetes_secret.postgres.data.password
    TFE_REDIS_PASSWORD: data.kubernetes_secret.redis.data.password
  }

}

# oc get secrets -n tfe 

# NAME                                     TYPE                DATA   AGE
# pgo-root-cacert                          Opaque              2      7d4h
# rec                                      Opaque              2      2d20h
# redb-redb                                Opaque              4      2d19h
# redis-enterprise-operator-service-cert   kubernetes.io/tls   3      7d4h
# tfeapp                                   Opaque              2      5d5h
# tfedb-cluster-cert                       Opaque              3      7d4h
# tfedb-instance1-dm9l-certs               Opaque              6      7d4h
# tfedb-pgbackrest                         Opaque              5      7d4h
# tfedb-pgbouncer                          Opaque              6      7d4h
# tfedb-pguser-tfeadmin                    Opaque              12     7d4h
# tfedb-replication-cert                   Opaque              3      7d4h