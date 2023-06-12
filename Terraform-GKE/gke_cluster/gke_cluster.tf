resource "google_container_cluster" "gke-cluster" {
  name                     = var.name
  location                 = "us-east1-b"
  remove_default_node_pool = true
  initial_node_count       = 2
  networking_mode          = "VPC_NATIVE"
  network                  = var.network
  subnetwork               = var.subnetwork


  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.1.0.0/28"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.11.0.0/21"
    services_ipv4_cidr_block = "10.12.0.0/21"
  }



  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.3/32"
      display_name = "net1"
    }
  }
}




resource "google_container_node_pool" "gke-cluster-nodes" {
  name       = var.name-node
  location   = "us-east1-b"
  cluster    = google_container_cluster.gke-cluster.name
  node_count = 2

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = "n1-standard-1"
    preemptible  = true
  }
}

