provider "google" {
credentials = "${file("key.json")}"
project     = var.project  // specify your project id
region      = var.region // specify region
}