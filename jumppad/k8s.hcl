resource "k8s_cluster" "k3s" {
  config {
    docker {
      no_proxy = [
        resource.container.registry.container_name,
        "auth-registry.demo.gs"
      ]
    }
  }

  network {
    id = resource.network.local.meta.id
  }
}

resource "helm" "vault" {
  disabled = !variable.install_vault

  cluster = resource.k8s_cluster.k3s

  repository {
    name = "hashicorp"
    url  = "https://helm.releases.hashicorp.com"
  }

  chart   = "hashicorp/vault" # When repository specified this is the name of the chart
  version = "v0.27.0"         # Version of the chart when repository specified

  values = "./config/vault-values.yaml"
}

# Configure the Vault Kubernetes service account
resource "k8s_config" "vault_auth" {
  disabled = !variable.install_vault

  cluster = resource.k8s_cluster.k3s

  paths = [
    "./config/vault_k8s_service_account.yaml",
  ]

  wait_until_ready = true
}

# Initialize the Vault server and configure
resource "exec" "vault_init" {
  disabled = !variable.install_vault

  depends_on = ["resource.helm.vault"]

  image {
    name = "shipyardrun/hashicorp-tools:v0.11.0"
  }

  script = file("./config/init_vault.sh")

  volume {
    source      = resource.k8s_cluster.k3s.kube_config.path
    destination = "/root/.kube/config"
  }

  environment = {
    VAULT_ADDR = "http://${resource.ingress.vault_http.local_address}"
    KUBECONFIG = "/root/.kube/config"
  }
}

resource "ingress" "vault_http" {
  port = 8200

  target {
    resource = resource.k8s_cluster.k3s
    port     = 8200

    config = {
      service   = "vault"
      namespace = "default"
    }
  }
}

resource "ingress" "ollama" {
  port = 11434

  target {
    resource = resource.k8s_cluster.k3s
    port     = 11434

    config = {
      service   = "ollama"
      namespace = "default"
    }
  }
}

output "VAULT_ADDR" {
  value = "http://${resource.ingress.vault_http.local_address}"
}

output "VAULT_TOKEN" {
  disabled = !variable.install_vault

  value = resource.exec.vault_init.output.vault_token
}

output "KUBECONFIG" {
  value = resource.k8s_cluster.k3s.kube_config.path
}