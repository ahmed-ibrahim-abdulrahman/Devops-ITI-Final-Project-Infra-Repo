output "jump_host_sa_email" {
  value = google_service_account.jump_host_sa.email
}

output "jump_host_ip" {
  value = google_compute_instance.jump_host.network_interface[0].network_ip
}