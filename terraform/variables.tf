# Project Information and Base Settings
variable "project_id" {
  description = "Set project_id in cstm.tfvars"
  default     = ""
}
variable "location" {
  description = "Location used throughout project"
  default     = "US"
}
variable "credentials_path" {
  description = "Set credentials_path in cstm.tfvars."
}
variable "credentials_file" {
  description = "Set credentials_file in cstm.tfvars."
}
# VM Settings
variable "vm_name" {
  description = "VM Instance name"
  default     = "default-vm"
}
variable "machine_type" {
  description = "VM Instance type listed is 4 vCPU (2 core), 16 GB memory"
  default     = "e2-standard-4"
}
variable "vm_zone" {
  description = "VM Instance Zone"
  default     = "us-west1-a"
}
variable "vm_image" {
  description = "VM Instance OS Image"
  default     = "ubuntu-2004-lts"
}
variable "vm_image_size" {
  description = "VM Instance OS Image Size"
  default     = "32"
}
variable "vm_network_interface" {
  description = "VM Instance Network Interface"
  default     = "default"
}
variable "vm_ssh_user" {
  description = "VM Instance ssh keys"
  default     = "default_user"
}
variable "vm_ssh_pub_key_path" {
  description = "Set vm_ssh_pub_key_path in cstm.tfvars"
}
variable "vm_ssh_pub_key_file" {
  description = "Set vm_ssh_pub_key_file in cstm.tfvars"
}

# Google Storage Bucket Information
variable "bucket_name" {
  description = "Google Storage Name"
  default     = "default_bucket"
}

# BigQuery Information
variable "bq_dataset_id" {
  description = "BigQuery Dataset ID"
  default     = "bq_default"
}
