resource "google_service_account" "iap-sa" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_member" "iap-sa-member" {
  project = "ahmed-ibrahim-project"
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${google_service_account.iap-sa.email}"
}






resource "google_compute_firewall" "rules" {

  project = "ahmed-ibrahim-project"
  name    = "allow-ssh"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}