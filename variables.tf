variable "k8s_api_server" {
    type = string
    description = "The hostname (in form of URI) of the Kubernetes API"
}

variable "client_certificate" {
    type = string
    description = "The client certificate for authenticating to the Kubernetes cluster"
}

variable "client_key" {
    type = string
    description = "The client key for authenticating to the Kubernetes cluster"
    sensitive = true
}

variable "cluster_ca_certificate" {
    type = string
    description = "The CA certificate for authenticating to the Kubernetes cluster"
}