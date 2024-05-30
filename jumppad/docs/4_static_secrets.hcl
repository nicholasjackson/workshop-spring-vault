resource "chapter" "static_secrets" {
  title = "Static Secrets"

  tasks = {}

  page "introduction" {
    content = template_file("./static_secrets/1_index.mdx", { db_address = variable.db_address })
  }

  page "adding" {
    content = template_file("./static_secrets/2_adding_secrets.mdx", { db_address = variable.db_address })
  }

  page "configuring_spring" {
    content = template_file("./static_secrets/3_configuring_spring.mdx", { db_address = variable.db_address })
  }

  page "new_controller" {
    content = template_file("./static_secrets/4_new_controller.mdx", { db_address = variable.db_address })
  }

  page "testing" {
    content = template_file("./static_secrets/zz_testing.mdx", { db_address = variable.db_address })
  }
}