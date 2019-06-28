resource "google_folder" "main" {
  display_name = "Shared services"
  parent       = "organizations/${var.org_id}"
}

