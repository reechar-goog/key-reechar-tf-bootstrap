resource "google_folder" "shared_services_folder" {
  display_name = "Shared services"
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "shared_services_tf_project" {
  name = "Shared Services Terraform"
  folder_id = "${google_folder.shared_services_folder.folder_id}"
  billing_account = "${var.billing_account}"
}
