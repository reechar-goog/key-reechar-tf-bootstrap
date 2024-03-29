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

resource "google_project_service" "shared_service_billing" {
  project = "reechar-key-shared-services-tf"
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "shared_services_cb" {
  project = "${google_project.shared_services_tf_project.project_id}"
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "shared_services_csr" {
  project = "${google_project.shared_services_tf_project.project_id}"
  service = "sourcerepo.googleapis.com"
}

resource "google_sourcerepo_repository" "reechar_key_shared_services_tf_repo" {
  project = "${google_project.shared_services_tf_project.project_id}"
  name = "reechar-key-shared-services-tf"
  depends_on = ["google_project_service.shared_services_csr"]
}


resource "google_storage_bucket" "shared_services_tf_state_bucket" {
  project = "${google_project.shared_services_tf_project.project_id}"
  name = "reechar-key-shared-services-tf"
}

resource "google_folder_iam_member" "shared_services_tf_owner" {
  folder = "${google_folder.shared_services_folder.name}"
  role    = "roles/owner"
  member  = "serviceAccount:${google_project.shared_services_tf_project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_folder_iam_member" "shared_services_tf_folder_adminW" {
  folder = "${google_folder.shared_services_folder.name}"
  role    = "roles/resourcemanager.folderAdmin"
  member  = "serviceAccount:${google_project.shared_services_tf_project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_folder_iam_member" "shared_services_tf_project_creator" {
  folder = "${google_folder.shared_services_folder.name}"
  role    = "roles/resourcemanager.projectCreator"
  member  = "serviceAccount:${google_project.shared_services_tf_project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_billing_account_iam_member" "shared_services_tf_billing_user" {
  billing_account_id = "${var.billing_account}"
  role               = "roles/billing.user"
  member  = "serviceAccount:${google_project.shared_services_tf_project.number}@cloudbuild.gserviceaccount.com"
}
