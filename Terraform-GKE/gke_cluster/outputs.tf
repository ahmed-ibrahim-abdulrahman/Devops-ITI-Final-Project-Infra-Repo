output "gke_cluster_name" {
  value = google_container_cluster.gke-cluster.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.gke-cluster.endpoint
}

output "gke_node_pool_instance_groups" {
  value = google_container_node_pool.gke-cluster-nodes.instance_group_urls
}