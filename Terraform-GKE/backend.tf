resource "google_storage_bucket" "tfstate_bucket" {
  name     = "tfstate-bucket-2023-123a"
  location = "us-central1"

  versioning {
    enabled = true
  }

}

terraform {
  backend "gcs" {
    bucket      = "tfstate-bucket-2023-123a"
    prefix      = "terraform/state"
    credentials = "key.json"
  }
}