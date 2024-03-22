# to do
# add scheduling strategy to use: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance.html#size
# create big query infra

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.21.0"
    }
  }
}

provider "google" {
  # Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS set
  # if creating a variable for credentials, you can use a function
  #  credentials = file(var.credentials)
  project     = var.project_id
  region      = var.location
}

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

    access_config {}
  }
  metadata = {
    ssh-keys = "${var.vm_ssh_user}:${file(var.vm_ssh_pub_key_file)}"
  }

}

# Create Google Storage Bucket
resource "random_id" "bucket_suffix" {
  byte_length = 8
}
resource "google_storage_bucket" "default_bucket" {
  name                        = "${var.bucket_name}_${random_id.bucket_suffix.hex}"
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

# Create Big Query Dataset
resource "google_bigquery_dataset" "bq_dataset" {
  dataset_id = var.bq_dataset_id
  project    = var.project_id
  location   = var.location

}