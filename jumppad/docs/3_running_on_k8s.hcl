resource "chapter" "running_on_k8s" {
  title = "Running on Kubernetes"

  tasks = {}

  page "introduction" {
    content = template_file("./running_on_k8s/1_index.mdx", { db_address = variable.db_address })
  }

  page "policy" {
    content = template_file("./running_on_k8s/2_defining_policy.mdx", { db_address = variable.db_address })
  }

  page "roles" {
    content = template_file("./running_on_k8s/3_creating_roles.mdx", { db_address = variable.db_address })
  }

  page "service_account" {
    content = template_file("./running_on_k8s/4_creating_sa.mdx", { db_address = variable.db_address })
  }

  page "service" {
    content = template_file("./running_on_k8s/5_create_service.mdx", { db_address = variable.db_address })
  }

  page "config" {
    content = template_file("./running_on_k8s/6_application_config.mdx", {
      db_address  = variable.db_address,
      vault_addr  = variable.vault_addr,
      vault_token = variable.vault_token
    })
  }

  page "deployment" {
    content = template_file("./running_on_k8s/7_deployment.mdx", { db_address = variable.db_address })
  }

  page "testing" {
    content = template_file("./running_on_k8s/zz_testing.mdx", {
      db_address  = variable.db_address,
      vault_addr  = variable.vault_addr,
      vault_token = variable.vault_token
    })
  }
}