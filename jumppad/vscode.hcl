resource "template" "bashrc" {
  
  source = <<-EOF
  export PATH="$${PATH}:/opt/java/bin:/usr/local/bin/gradle/gradle-8.7/bin"
  export JAVA_HOME="/opt/java"
  EOF

  destination = "${data("vscode")}/.bashrc"
}

resource "template" "vscode_settings" {

  source = <<-EOF
  {
      "workbench.colorTheme": "GitHub Dark",
      "editor.fontSize": 16,
      "workbench.iconTheme": "material-icon-theme",
      "terminal.integrated.fontSize": 16
  }
  EOF

  destination = "${data("vscode")}/settings.json"
}

resource "template" "vscode_jumppad" {

  source = <<-EOF
  {
  "tabs": [
    {
      "name": "Docs",
      "uri": "${variable.docs_url}",
      "type": "browser",
      "active": true
    },
    {
      "name": "SpringBoot",
      "location": "editor",
      "type": "terminal"
    },
    {
      "name": "Terminal",
      "location": "editor",
      "type": "terminal"
    }
  ]
  }
  EOF

  destination = "${data("vscode")}/workspace.json"
}

resource "template" "boot_config" {
  source = <<-EOF
  logging:
    level:
      root: INFO
      org:
        springframework:
          vault:
            core:
              env: DEBUG
  spring:
    jpa:
      show_sql: true
      hibernate:
        ddl-auto: none
      properties:
        hibernate:
          dialect: org.hibernate.dialect.PostgreSQLDialect
    datasource:
      driverClassName: org.postgresql.Driver
      url: jdbc:postgresql://postgres.container.local.jmpd.in:5432/payments
  spring.cloud.vault:
    host: ${docker_ip()}
    scheme: http
    port: 8200
    fail-fast: true
    authentication: TOKEN
    token: ${resource.exec.vault_init.output.vault_token}
    kv:
      enabled: false
    database:
      enabled: true
      role: writer
      backend: database
      username-property: spring.datasource.username
      password-property: spring.datasource.password
  spring.config.import: vault://
  EOF
  
  destination = "${data("vscode")}/application.yaml"
}

resource "container" "vscode" {

  network {
    id = resource.network.local.meta.id
  }

  image {
    name = "nicholasjackson/spring-vault-vscode:v0.0.2"
  }

  volume {
    source      = "./working"
    destination = "/usr/src"
  }
  
  volume {
    source      = resource.template.boot_config.destination
    destination = "/usr/src/src/main/resources/application.yaml"
  }

  volume {
    source      = resource.template.vscode_jumppad.destination
    destination = "/usr/src/.vscode/workspace.json"
  }

  volume {
    source      = resource.template.vscode_settings.destination
    destination = "/usr/src/.vscode/settings.json"
  }

  volume {
    source      = "/var/run/docker.sock"
    destination = "/var/run/docker.sock"
  }

  volume {
    source      = resource.k8s_cluster.k3s.kube_config.path
    destination = "/root/.kube/config"
  }
  
  volume {
    source      = resource.template.bashrc.destination
    destination = "/root/.bashrc"
  }

  environment = {
    KUBE_CONFIG_PATH  = "/root/.kube/config"
    KUBECONFIG        = "/root/.kube/config"
    DEFAULT_FOLDER    = "/usr/src"
    LC_ALL            = "C"
    VAULT_ADDR        = "http://${resource.ingress.vault_http.local_address}"
    VAULT_TOKEN       = resource.exec.vault_init.output.vault_token
  }

  // vscode
  port {
    local = 8000
    host  = 8000
  }

  health_check {
    timeout = "100s"

    http {
      address       = "http://localhost:8000/"
      success_codes = [200, 302, 403]
    }
  }

  //resources {
  //  gpu {
  //    driver     = "nvidia"
  //    device_ids = ["0"]
  //  }
  //}
}