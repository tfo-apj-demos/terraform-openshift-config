output "tfe_helm_output" {
  value = yamlencode(local.tfe_helm_values)
  sensitive = false
}