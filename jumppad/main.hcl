variable "docs_url" {
  default = "http://localhost"
}

variable "install_vault" {
  default = true
}

variable "db_address" {
  default = "10.100.0.180"
}

variable "registry_ip_address" {
  default = "10.100.0.183"
}

resource "network" "local" {
  subnet = "10.100.0.0/16"
}

module "docs" {
  source = "./docs"

  variables = {
    vscode      = resource.container.vscode.meta.id
    network     = resource.network.local.meta.id
    db_address  = resource.container.postgres.network.0.ip_address
    vault_token = resource.exec.vault_init.output.vault_token
    vault_addr  = docker_ip()
  }
}