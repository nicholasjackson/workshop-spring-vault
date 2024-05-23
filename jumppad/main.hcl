variable "docs_url" {
  default = "http://localhost:8080"
}

variable "install_vault" {
  default = true
}

resource "network" "local" {
  subnet = "10.6.0.0/16"
}

variable "registry_ip_address" {
  default = "10.6.0.183"
}