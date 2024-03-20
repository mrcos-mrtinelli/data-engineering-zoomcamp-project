# to do
# add scheduling strategy to use: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance.html#size
# extract variables and create variables.tf file
# create big query infra

# Create Google Compute VM
resource "google_compute_instance" "default_vm" {
  name         = "default-vm"
  machine_type = "e2-standard-4"
  zone         = "us-west1-a"
  project      = "dez-course-2024"
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
      size  = "32"
    }
  }
  network_interface {
    network = "default"
  }
}

# Create Google Storage Bucket
resource "random_id" "bucket_prefix" {
  byte_length = 8
}
resource "google_storage_bucket" "default_bucket" {
  name                        = "default_bucket_4_data_engineering_project"
  location                    = "US"
  project                     = "dez-course-2024"
  force_destroy               = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 32 // days
    }
  }
}