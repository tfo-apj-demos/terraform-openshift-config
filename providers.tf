
provider "kubernetes" {
  # Configuration options
  host = var.k8s_api_server
  
}

provider "helm" {
  # Configuration options
  kubernetes {  
    host = var.k8s_api_server
  
  }
}