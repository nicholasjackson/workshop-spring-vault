resource "container" "postgres" {
  image {
    name = "postgres:15.4"
  }

  network {
    id = resource.network.local.meta.id
    ip_address = variable.db_address
  }

  port {
    local           = 5432
    remote          = 5432
    host            = 5432
    open_in_browser = ""
  }

  environment = {
    POSTGRES_PASSWORD = "password"
    POSTGRES_DB       = "payments"
  }

  volume {
    source      = "./config/setup.sql"
    destination = "/docker-entrypoint-initdb.d/setup.sql"
  }
}