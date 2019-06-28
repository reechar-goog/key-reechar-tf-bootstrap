resource "google_folder" "shared_services_folder" {
  display_name = "Shared services"
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "shared_services_tf_project" {
  name = "Shared Services Terraform"
  project_id = "reechar-key-shared-services-tf"
  folder_id = "${google_folder.shared_services_folder.name}"
  billing_account = "${var.billing_account}"
}
