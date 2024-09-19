output "tfe_helm_output" {
  value = nonsensitive(yamldecode(local.tfe_helm_values))
  sensitive = false
}