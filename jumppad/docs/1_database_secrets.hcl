resource "chapter" "database_secrets" {
  title = "Database Secrets"

  tasks = {}

  page "introduction" {
    content = file("docs/database_secrets/index.mdx")
  }
}