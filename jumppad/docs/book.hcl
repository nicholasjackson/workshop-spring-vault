resource "book" "spring_vault" {
  title = "Using Spring Vault"

  chapters = [
    resource.chapter.database_secrets,
  ]
}

resource "docs" "docs" {
  network {
    id = resource.network.main.meta.id
  }

  content = [
    resource.book.spring_vault
  ]

  assets = "${dir()}/assets"
}