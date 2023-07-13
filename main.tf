resource "google_compute_network" "terraform-test-vpc" {
name                    = "terraform-test-vpc" //give the vpc name
provider                = google
auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform-test-subnet" {
name          = "terraform-test-subnet"   // give the subnet name
ip_cidr_range = "10.2.0.0/16"       //give the cidr_range
region        = "us-central1"     // give the region
network       = google_compute_network.terraform-test-vpc.id //specify vpc
secondary_ip_range {
range_name    = "tf-test-secondary-range-update1"
ip_cidr_range = "192.168.10.0/24"
}
}

resource "google_compute_instance" "terraform-vm" {
name         = var.instance_name           //give the instance name
machine_type = var.machine_type           // choose machine_type
zone         = var.zone                        // specify zone
boot_disk {
initialize_params {
image = var.machine_image // choose image
type  = var.disk_type
size  = var.disk_size
}
}
network_interface {
network = google_compute_network.terraform-test-vpc.id // specify vpc
subnetwork = google_compute_subnetwork.terraform-test-subnet.id // specify subnet
}
}