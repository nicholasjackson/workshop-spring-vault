resource "chapter" "database_secrets" {
  title = "Database Secrets"

  tasks = {
    enable_database = resource.task.enable_database
  }

  page "introduction" {
    content = template_file("./database_secrets/1_index.mdx", { db_address = variable.db_address })
  }

  page "configuring_database" {
    content = template_file("./database_secrets/2_configuring_database.mdx", { db_address = variable.db_address })
  }

  page "creating_roles" {
    content = template_file("./database_secrets/3_creating_roles.mdx", { db_address = variable.db_address })
  }

  page "generating_credentials" {
    content = template_file("./database_secrets/4_generating_credentials.mdx", { db_address = variable.db_address })
  }

  page "configuring_spring" {
    content = template_file("./database_secrets/5_configuring_spring.mdx", {
      db_address  = variable.db_address,
      vault_addr  = variable.vault_addr,
      vault_token = variable.vault_token
    })
  }

  page "injecting_credentials" {
    content = template_file("./database_secrets/6_injecting_credentials.mdx", {
      db_address  = variable.db_address,
      vault_addr  = variable.vault_addr,
      vault_token = variable.vault_token
    })
  }

  page "testing" {
    content = template_file("./database_secrets/zz_testing.mdx", { db_address = variable.db_address })
  }
}

resource "task" "enable_database" {
  prerequisites = []

  config {
    user   = "root"
    target = variable.vscode
  }

  condition "database_enabled" {
    description = "Vault database engine is enabled"

    check {
      script          = file("database_secrets/checks/c_database_enabled")
      failure_message = "Run the previous command to enable the database engine"
    }

    solve {
      script  = file("database_secrets/checks/r_database_enabled")
      timeout = 60
    }
  }
}