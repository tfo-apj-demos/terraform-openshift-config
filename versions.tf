terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }

    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1"
    }
  }
}
