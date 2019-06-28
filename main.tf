resource "google_folder" "main" {
  display_name = "Shared Services"
  parent       = "organizations/${var.org_id}"
}

