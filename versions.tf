terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }

    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1"
    }
  }
}
