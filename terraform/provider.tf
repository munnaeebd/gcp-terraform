terraform {
    required_version = ">= 1.3"
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = "< 5.0, >= 4.64"
        }
        google-beta = {
        source  = "hashicorp/google-beta"
        version = "< 5.0, >= 4.64"
        }
    }
    backend "gcs" {
        bucket  = "mrportal-tfstate"
        prefix  = "terraform/state"
    }
}

provider "google" {
  project = "munna-rnd"
  region  = "asia-southeast1"

}

data "google_project" "project" {}
