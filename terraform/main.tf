# to do
# add scheduling strategy to use: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance.html#size
# extract variables and create variables.tf file

resource "google_compute_instance" "pipeline-vm-instance" {
  name         = "pipeline-vm"
  machine_type = "e2-standard-4"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
      size = "32"
    }
  }
  network_interface {
    network = "default"
  }
}