output "vpc_id" {
  value = google_compute_network.vpc.self_link
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "vpc_auto_create_subnetworks" {
  value = google_compute_network.vpc.auto_create_subnetworks
}