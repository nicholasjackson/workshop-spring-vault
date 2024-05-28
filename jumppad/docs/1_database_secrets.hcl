resource "chapter" "database_secrets" {
  title = "Database Secrets"

  tasks = {}

  page "introduction" {
    content = template_file("./database_secrets/1_index.mdx", {db_address = variable.db_address})
  }
  
  page "configuring_spring" {
    content = template_file("./database_secrets/2_integrating_with_spring.mdx", {db_address = variable.db_address})
  }
  
  page "testing" {
    content = template_file("./database_secrets/3_testing.mdx", {db_address = variable.db_address})
  }
}