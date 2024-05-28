resource "chapter" "database_encryption" {
  title = "Database Encryption"

  tasks = {}

  page "introduction" {
    content = template_file("./database_encryption/1_index.mdx", {db_address = variable.db_address})
  }
  
  page "integration" {
    content = template_file("./database_encryption/2_integrating.mdx", {db_address = variable.db_address})
  }
  
  page "testing" {
    content = template_file("./database_encryption/3_testing.mdx", {db_address = variable.db_address})
  }
}