provider "google" {
  region      = "us-east1"
  project     = "ahmed-ibrahim-project"
  zone        = "us-east1-b"
  credentials = file("key.json")


}


