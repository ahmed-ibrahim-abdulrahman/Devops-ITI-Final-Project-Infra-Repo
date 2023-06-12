output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "ip-range" {
  value = google_compute_subnetwork.subnet.ip_cidr_range
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}
