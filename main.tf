# ==========================================
# 1. TERRAFORM SETTINGS & REMOTE STATE LOCKING
# ==========================================
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

  backend "gcs" {
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ==========================================
# 2. DEPLOYMENT LOGIC
# ==========================================

locals {
  bindings = flatten([
    for group, roles in var.team_permissions : [
      for role in roles : {
        group = group
        role  = role
      }
    ]
  ])
}

resource "google_project_iam_member" "global_multi_team_access" {
  for_each = {
    for b in local.bindings : "${b.group}-${b.role}" => b
  }

  project = var.project_id
  role    = each.value.role
  member  = "group:${each.value.group}"
}