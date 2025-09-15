# Use variables for easy customization
variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
  default     = "qwiklabs-gcp-03-fa7edfd03d8e"
}

variable "region" {
  description = "The region where the instance will be created."
  type        = string
  default     = "us-central1"
}

# -------------------------------------------------------------------------------------
# Required variables
# -------------------------------------------------------------------------------------

variable "zone" {
  default = "us-central1-a"
}

variable "service_account_key_file" {
  type = string
}

# -------------------------------------------------------------------------------------
# Locals
# -------------------------------------------------------------------------------------

locals {
  project_id               = var.project_id
  region                   = var.region
  zone                     = var.zone
  service_account_key_file = var.service_account_key_file
}


# -------------------------------------------------------------------------------------
# Enable required APIs
# -------------------------------------------------------------------------------------
module "la_api_batch" {
  source         = "gcs::https://www.googleapis.com/storage/v1/terraform-lab-foundation/basics/api_service/dev"
  gcp_project_id = var.project_id
  gcp_region     = var.region
  gcp_zone       = var.zone
  api_services = [
    "cloudresourcemanager.googleapis.com",
    "storage.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "notebooks.googleapis.com",
    "aiplatform.googleapis.com",
    "datacatalog.googleapis.com",
    "visionai.googleapis.com"
  ]
}



# -------------------------------------------------------------------------------------
# Create GSC bucket & log router for VPC flow logs
# -------------------------------------------------------------------------------------

resource "random_string" "main" {
  length      = 16
  min_lower   = 8
  min_numeric = 8
  special     = false
}
resource "google_workbench_instance" "instance" {
  name     = "workbench-instance"
  location = local.zone
  gce_setup {
    machine_type = "n1-standard-2"


    shielded_instance_config {
      enable_secure_boot          = false
      enable_vtpm                 = false
      enable_integrity_monitoring = false
    }

    disable_public_ip = false

    tags = ["notebook-instance"]
  }
  depends_on = [module.la_api_batch]
  labels = {
    git_commit           = "4d011dc4122c8bae2c5f19b06762561325f29a70"
    git_file             = "code__vertex_tf"
    git_last_modified_at = "2025-08-25-22-35-36"
    git_last_modified_by = "98756224tprenderville"
    git_modifiers        = "98756224tprenderville"
    git_org              = "tlh2857-2024"
    git_repo             = "cortex-cloud-devsecops-workshop-2"
    yor_name             = "instance"
    yor_trace            = "fab2e8e2-72aa-43c1-bfea-c7f9b355f23c"
  }
}
