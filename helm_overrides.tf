locals {
  helm_overrides_values = {
    # TFE image settings
    tfe_replica_count       = 1
    tfe_image_repository_url = "images.releases.hashicorp.com"
    tfe_image_name           = "hashicorp/terraform-enterprise"
    tfe_image_tag            = "v202406-1"

    # TFE config settings
    tfe_hostname = "tfe.hashicorp.local"

    # Database settings
    tfe_database_host       = "postgres:5432"
    tfe_database_name       = "tfe"
    tfe_database_user       = "dummy"
    tfe_database_parameters = "sslmode=disable"
    # Object storage settings
    tfe_object_storage_type                                 = "s3"
    tfe_object_storage_s3_bucket                            = "s3_bucketname"
    tfe_object_storage_s3_region                            = "us-west-2"
    tfe_object_storage_s3_endpoint                          = ""
    tfe_object_storage_s3_use_instance_profile              = false
    tfe_object_storage_s3_access_key_id                     = ""
    tfe_object_storage_s3_secret_access_key                 = ""
    tfe_object_storage_s3_server_side_encryption            = ""

    # Redis settings
    tfe_redis_host     = "redis"
    tfe_redis_use_auth = true
    tfe_redis_use_tls  = false
  }

  tfe_helm_values = templatestring("${path.module}/templates/helm_overrides_values.yaml.tpl", local.helm_overrides_values)
}

# resource "local_file" "helm_overrides_values" {
#   count = var.create_helm_overrides_file ? 1 : 0

#   content  = templatestring("${path.module}/templates/helm_overrides_values.yaml.tpl", local.helm_overrides_values)
#   filename = "${path.cwd}/helm/module_generated_helm_overrides.yaml"

#   lifecycle {
#     ignore_changes = [content, filename]
#   }
# }