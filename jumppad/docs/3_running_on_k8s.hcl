resource "chapter" "running_on_k8s" {
  title = "Running on Kubernetes"

  tasks = {}

  page "introduction" {
    content = template_file("./running_on_k8s/1_index.mdx", {db_address = variable.db_address})
  }
  
  page "deployment" {
    content = template_file("./running_on_k8s/2_deployment.mdx", {db_address = variable.db_address})
  }
  
  page "testing" {
    content = template_file("./running_on_k8s/3_testing.mdx", {db_address = variable.db_address})
  }
}