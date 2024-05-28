variable "network" {
  default = ""
}

variable "db_address" {
  default = ""
}

resource "book" "spring_vault" {
  title = "Using Spring Vault"

  chapters = [
    resource.chapter.database_secrets,
    resource.chapter.database_encryption,
    resource.chapter.running_on_k8s,
  ]
}

resource "docs" "docs" {
  network {
    id = variable.network 
  }

  content = [
    resource.book.spring_vault
  ]

  assets = "${dir()}/assets"
}