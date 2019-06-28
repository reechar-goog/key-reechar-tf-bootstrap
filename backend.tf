terraform {
  backend "gcs" {
    bucket  = "reechar-key-tf-bootstrap"
    prefix  = "folders"
  }
}
