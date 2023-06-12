resource "google_service_account" "jump_host_sa" {
  account_id   = "jump-host-sa"
  display_name = "Jump Host Service Account"
}


resource "google_project_iam_binding" "jump_host_sa_binding" {
  project = "ahmed-ibrahim-project"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.jump_host_sa.email}"
  ]
}

resource "google_compute_address" "internal_ip" {
  region       = "us-east1"
  project      = "ahmed-ibrahim-project"
  address_type = "INTERNAL"
  subnetwork   = var.subnetwork
  name         = "ip"
  address      = "10.0.0.3"
}




resource "google_compute_instance" "jump_host" {
  project      = "ahmed-ibrahim-project"
  zone         = "us-east1-b"
  name         = var.name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  metadata = {
    startup-script = file("startup.sh")
  }

  network_interface {
    subnetwork = var.subnetwork
    network_ip = google_compute_address.internal_ip.address
  }

  service_account {
    email  = google_service_account.jump_host_sa.email
    scopes = ["cloud-platform"]
  }


}

