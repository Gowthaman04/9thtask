provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file) # JSON key file
}

resource "google_container_cluster" "gke_cluster" {
  name     = "demo-gke-cluster"
  location = var.region
  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
  }
}

output "kubeconfig" {
  value = google_container_cluster.gke_cluster.endpoint
}

