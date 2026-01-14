# terraform-openshift-config

This repository manages the **infrastructure and operator layer** for OpenShift platform applications. It is responsible for installing operators, creating namespaces, and establishing the foundational resources that application instances depend on.

## Relationship with terraform-openshift-platform-apps

This repo works in conjunction with [terraform-openshift-platform-apps](https://github.com/tfo-apj-demos/terraform-openshift-platform-apps):

| This Repo (config) | platform-apps Repo |
|-------------------|-------------------|
| Installs operators via OLM subscriptions | Deploys application instances (CRDs, Helm releases) |
| Creates namespaces | Configures application-specific settings |
| Sets up OperatorGroups | Creates routes, secrets, and integrations |
| Establishes RBAC foundations | Deploys Vault Secrets Operator integrations |

**Deployment Order:** Run this repo first, then run `terraform-openshift-platform-apps`.

## What This Repo Deploys

| Application | Resources Created |
|-------------|-------------------|
| **Terraform Enterprise** | Namespace, PostgreSQL operator subscription, OperatorGroup, S3 bucket claim, HCP TF Operator |
| **Ansible Automation Platform** | Namespace, AAP operator subscription, OperatorGroup |
| **AWX** | Namespace, AWX operator (via Helm) |
| **Vault Secrets Operator** | Operator subscription, ServiceAccount, ClusterRole, RoleBinding |
| **GitLab** | Namespace, GitLab operator subscription, OperatorGroup |
| **GitLab Runner** | Operator subscription, OperatorGroup |
| **Red Hat Developer Hub** | Namespace, RHDH operator subscription, OperatorGroup |
| **Cert-Manager** | Operator subscription, OperatorGroup |
| **IBM DB2** | Operator subscription, OperatorGroup, IBM catalog |
| **Keycloak** | Operator subscription, OperatorGroup |

## Providers

- `kubernetes` - For creating namespaces and deploying manifests
- `helm` - For deploying operator Helm charts (e.g., AWX operator)
- `boundary` - For registering services with HashiCorp Boundary

## Usage

```hcl
module "openshift_config" {
  source = "app.terraform.io/tfo-apj-demos/openshift-config/openshift"
  
  host                   = var.openshift_api_url
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}
```
