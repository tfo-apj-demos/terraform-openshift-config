replicaCount: ${tfe_replica_count}
tls:
  certificateSecret: <tfe-certs>
  caCertData: |
    <base64-encoded TFE CA bundle>

image:
 repository: ${tfe_image_repository_url}
 name: ${tfe_image_name}
 tag: ${tfe_image_tag}

openshift:
   enabled: true
env:
  secretRefs:
    - name: tfe-secrets
  
  variables:
    # TFE config settings
    TFE_HOSTNAME: ${tfe_hostname}

    # Database settings
    TFE_DATABASE_HOST: ${tfe_database_host}
    TFE_DATABASE_NAME: ${tfe_database_name}
    TFE_DATABASE_USER: ${tfe_database_user}
    TFE_DATABASE_PARAMETERS: ${tfe_database_parameters}

    # Object storage settings
    TFE_OBJECT_STORAGE_TYPE: ${tfe_object_storage_type}
    TFE_OBJECT_STORAGE_S3_BUCKET: ${tfe_object_storage_s3_bucket}
    TFE_OBJECT_STORAGE_S3_REGION: ${tfe_object_storage_s3_region}
    TFE_OBJECT_STORAGE_S3_ENDPOINT: ${tfe_object_storage_s3_endpoint}
    TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE: ${tfe_object_storage_s3_use_instance_profile}
    TFE_OBJECT_STORAGE_S3_ACCESS_KEY_ID: ${tfe_object_storage_s3_access_key_id}
    TFE_OBJECT_STORAGE_S3_SECRET_ACCESS_KEY: ${tfe_object_storage_s3_secret_access_key}
    TFE_OBJECT_STORAGE_S3_SERVER_SIDE_ENCRYPTION: ${tfe_object_storage_s3_server_side_encryption}

    # Redis settings
    TFE_REDIS_HOST: ${tfe_redis_host}
    TFE_REDIS_USE_AUTH: ${tfe_redis_use_auth}
    TFE_REDIS_USE_TLS: ${tfe_redis_use_tls}
    



#     replicaCount: 1
# tls:
#   certData: <BASE_64_ENCODED_CERTIFICATE_PEM_FILE>
#   keyData: <BASE_64_ENCODED_CERTIFICATE_PRIVATE_KEY_PEM_FILE>
#   caCertData: <BASE_64_ENCODED_CERTIFICATE_CA_CERTIFICATE_PEM_FILE>
# image:
#   repository: images.releases.hashicorp.com
#   name: hashicorp/terraform-enterprise
#   tag: <vYYYYMM-#>
# openshift:
#   enabled: true
# env:
#   variables:
#     TFE_HOSTNAME: <TFE hostname (DNS) e.g. terraform.example.com>
#     TFE_IACT_SUBNETS: <IACT subnet, eg. 10.0.0.0/8,192.168.0.0/24>

#     # Database settings.
#     TFE_DATABASE_HOST: <Database hostname with port e.g "xxx.postgres.database.azure.com:5432">
#     TFE_DATABASE_NAME: <Database name>
#     TFE_DATABASE_PARAMETERS: <Database extra params e.g "sslmode=disable">
#     TFE_DATABASE_USER: <Database user>

#     # Redis settings.
#     TFE_REDIS_HOST: <Redis host, eg. 10.101.0.4>
#     TFE_REDIS_USE_TLS: <To use tls? eg. "false">
#     TFE_REDIS_USE_AUTH: <To use customized credential to authenticate? eg. "true">
#     TFE_REDIS_USER: <Redis username>

#     # Azure container storage settings.
#     TFE_OBJECT_STORAGE_TYPE: s3
#     TFE_OBJECT_STORAGE_S3_BUCKET: <S3 bucket name>
#     TFE_OBJECT_STORAGE_S3_REGION: <S3 region>
#     TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE: false
#     # Terraform Enterprise on OpenShift Required settings
#     TFE_RUN_PIPELINE_IMAGE: <URL and path to the custom tfc-agent image>
#     TFE_RUN_PIPELINE_KUBERNETES_IMAGE_PULL_SECRET_NAME: <The name of an imagePullSecret created in the agents namespace for the tfc-agent image>

#   secrets:
#     TFE_DATABASE_PASSWORD: <Database password>
#     TFE_OBJECT_STORAGE_AZURE_ACCOUNT_KEY: <Azure storage account key>
#     TFE_REDIS_PASSWORD: <Redis password>
#     TFE_LICENSE: <Hashicorp license>
#     TFE_ENCRYPTION_PASSWORD: <Encryption password>
