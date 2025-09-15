provider "google" {
  project = "qwiklabs-gcp-01-b0a28c8299e3"
  region  = "us-central1"
}

resource "google_storage_bucket" "example" {
  name          = "demo-${random_id.rand_suffix.hex}"
  location      = "us-central1"
  force_destroy = true

  uniform_bucket_level_access = false
  public_access_prevention    = "enforced"
  labels = {
    git_commit           = "1f2caf501aaa1ed96779c2e5aacfd58d4b5687b6"
    git_file             = "code__build__gcs_tf"
    git_last_modified_at = "2025-09-15-19-20-56"
    git_last_modified_by = "terryleehillisxsiam"
    git_modifiers        = "terryleehillisxsiam"
    git_org              = "tlh2857-2024"
    git_repo             = "cortex-cloud-devsecops-workshop-2"
    yor_name             = "example"
    yor_trace            = "eb0e54b1-8bd7-4c33-828c-36c73016e48c"
  }
}

resource "random_id" "rand_suffix" {
  byte_length = 4
}

output "bucket_name" {
  value = google_storage_bucket.example.name
}
