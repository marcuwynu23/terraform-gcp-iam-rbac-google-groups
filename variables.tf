variable "project_id" {
  description = "The GCP Project ID where IAM bindings will be applied."
  type        = string
}

variable "region" {
  description = "The GCP region for any regional resources (if needed)."
  type        = string
  default     = "us-central1"
}

variable "team_permissions" {
  description = "Map of free consumer Google Groups to their assigned GCP roles."
  type        = map(list(string))
  default = {
    "my-free-devops-team@googlegroups.com" = [
      "roles/compute.admin",
      "roles/run.admin",
      "roles/cloudbuild.admin",
      "roles/storage.admin"
    ],
    "my-free-dev-team@googlegroups.com" = [
      "roles/compute.viewer",
      "roles/run.developer",
      "roles/cloudbuild.editor",
      "roles/storage.objectUser"
    ]
  }
}