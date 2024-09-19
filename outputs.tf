output "tfe_helm_output" {
  value = nonsensitive( provider::kubernetes::manifest_decode(local.tfe_helm_values) )
  sensitive = false
}