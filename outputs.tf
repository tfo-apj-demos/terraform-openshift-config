output "tfe_helm_output" {
  value = nonsensitive(yamlencode(local.tfe_helm_values))
  sensitive = false
}