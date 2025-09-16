resource "google_storage_bucket" "sample" {
  name                        = "demo2-${random_id.Rand_suffix.hex}"
  location                    = "us-central1"
  force_destroy               = true
  uniform_bucket_level_access = false

  #public_access_prevention = "enforced" ##comment out this line of code for demo
  labels = {
    git_commit           = "ac7014815be2ed12ce2e6df1a7887e83d92da529"
    git_file             = "code__build__gcs_tf"
    git_last_modified_at = "2025-09-15-22-15-32"

    git_last_modified_by = "terryleehillisxsiam"
    git_modifiers        = "terryleehillisxsiam"
    git_org              = "tlh2857-2024"
    git_repo             = "cortex-cloud-devsecops-workshop-2"
    yor_name             = "sample"
    yor_trace            = "5a36ce01-e1ec-46c8-941b-a75a79f5a434"
  }
}

resource "random_id" "Rand_suffix" {
  byte_length = 4
}

output "Bucket_name" {
  value = google_storage_bucket.sample.name
}
