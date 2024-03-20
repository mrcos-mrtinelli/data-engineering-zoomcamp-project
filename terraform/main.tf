# to do
# add scheduling strategy to use: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance.html#size
# extract variables and create variables.tf file
# create big query infra

# Create Google Compute VM
resource "google_compute_instance" "default_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.vm_zone
  project      = var.project_id
  boot_disk {
    initialize_params {
      image = var.vm_image
      size  = var.vm_image_size
    }
  }
  network_interface {
    network = var.vm_network_interface
  }
}

# Create Google Storage Bucket
resource "random_id" "bucket_suffix" {
  byte_length = 8
}
resource "google_storage_bucket" "default_bucket" {
  name                        = "${var.bucket_name}_${xrandom_id.bucket_suffix.hex}"
  location                    = var.location
  project                     = var.project_id
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