resource "google_compute_subnetwork" "subnet" {
  name                     = var.name
  region                   = "us-east1"
  network                  = var.network
  ip_cidr_range            = "10.0.0.0/24"
  private_ip_google_access = true
}

