provider "google" {
  credentials = jsondecode(var.gcp_credentials)
  project     = var.project_id
  region      = var.region
}

resource "google_container_cluster" "gke_cluster" {
  name     = "demo-gke-cluster"
  location = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  initial_node_count = 2
}

