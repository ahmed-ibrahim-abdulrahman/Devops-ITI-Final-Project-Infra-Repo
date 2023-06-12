resource "google_compute_router" "router" {
  region  = "us-east1"
  project = "ahmed-ibrahim-project"
  name    = "router-a"
  network = var.network
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-a"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  region                             = "us-east1"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = var.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}



