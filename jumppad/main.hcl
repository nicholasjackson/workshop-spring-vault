variable "docs_url" {
  default = "http://localhost"
}

variable "install_vault" {
  default = true
}

variable "db_address" {
  default = "10.6.0.180"
}

resource "network" "local" {
  subnet = "10.6.0.0/16"
}

variable "registry_ip_address" {
  default = "10.6.0.183"
}

module "docs" {
  source = "./docs"

  variables = {
    network = resource.network.local.meta.id
    db_address = resource.container.postgres.network.0.ip_address
  }
}