resource "chapter" "database_encryption" {
  title = "Database Encryption"

  tasks = {}

  page "introduction" {
    content = template_file("./database_encryption/1_index.mdx", { db_address = variable.db_address })
  }

  page "creating_keys" {
    content = template_file("./database_encryption/2_creating_keys.mdx", { db_address = variable.db_address })
  }

  page "encrypting_data" {
    content = template_file("./database_encryption/3_encrypting_data.mdx", { db_address = variable.db_address })
  }

  page "decrypting_data" {
    content = template_file("./database_encryption/4_decrypting_data.mdx", { db_address = variable.db_address })
  }

  page "integration" {
    content = template_file("./database_encryption/5_integrating.mdx", { db_address = variable.db_address })
  }

  page "adding_vault" {
    content = template_file("./database_encryption/6_adding_vault.mdx", { db_address = variable.db_address })
  }

  page "encrypting_datat" {
    content = template_file("./database_encryption/7_encrypting_data.mdx", { db_address = variable.db_address })
  }

  page "wiring_listener" {
    content = template_file("./database_encryption/8_wiring_the_listener.mdx", { db_address = variable.db_address })
  }

  page "testing" {
    content = template_file("./database_encryption/zz_testing.mdx", { db_address = variable.db_address })
  }
}