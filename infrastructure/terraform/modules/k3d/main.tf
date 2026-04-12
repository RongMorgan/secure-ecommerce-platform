terraform {
  required_providers {
    k3d = {
      source  = "pvotal-tech/k3d"
      version = "~> 0.0.7"
    }
  }
}

resource "k3d_cluster" "platform" {
  name    = "secure-ecommerce"
  servers = 1
  agents  = 2
  
  kube_api {
    host_ip   = "0.0.0.0"
    host_port = 6443
  }
  
  port {
    host_port      = "80"
    container_port = "80"
  }
  
  port {
    host_port      = "443"
    container_port = "443"
  }
  
  port {
    host_port      = "8080"
    container_port = "8080"
  }
  
  k3s {
    extra_args {
      arg          = "--disable=traefik"
      node_filters = ["all"]
    }
    extra_args {
      arg          = "--flannel-backend=none"
      node_filters = ["all"]
    }
    extra_args {
      arg          = "--disable-network-policy"
      node_filters = ["all"]
    }
  }
}

output "kubeconfig_path" {
  value = k3d_cluster.platform.credentials[0].kubeconfig_path
}
