variable "network" {
  default = ""
}

variable "vscode" {
  default = ""
}

variable "db_address" {
  default = ""
}

variable "vault_token" {
  default = ""
}

variable "vault_addr" {
  default = ""
}

resource "book" "spring_vault" {
  title = "Using Spring Vault"

  chapters = [
    resource.chapter.database_secrets,
    resource.chapter.database_encryption,
    resource.chapter.running_on_k8s,
    resource.chapter.static_secrets,
  ]
}

resource "docs" "docs" {
  network {
    id = variable.network
  }

  image {
    name = "ghcr.io/jumppad-labs/docs:v0.4.1"
  }

  content = [
    resource.book.spring_vault
  ]

  assets = "${dir()}/assets"
}