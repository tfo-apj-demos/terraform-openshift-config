output "tfe_helm_output" {
  value = nonsensitive(replace(local.tfe_helm_values,  "/((?:^|\n)[\\s-]*[^:\\n]+?):/", "\n$1:"))
  sensitive = false
}