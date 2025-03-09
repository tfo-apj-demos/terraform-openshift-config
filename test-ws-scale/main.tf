# using tfe provider create 10 workspaces with ws1-ws10
#
provider "tfe" {
    hostname = "tfe.hashicorp.local"
    token    = "aaaaa"
}
resource "tfe_workspace" "workspaces" {
  count          = var.workspace_count
  name           = "ws${count.index + 1}"
  organization   = "gcve"
  queue_all_runs = true
  auto_apply     = true
  force_delete   = true
}
                                                                            
# set agent pool for each workspace
resource "tfe_agent_pool" "agent_pool" {
  count        = var.workspace_count
  name         = "agent-pool-${count.index + 1}"
  organization = "gcve"
}