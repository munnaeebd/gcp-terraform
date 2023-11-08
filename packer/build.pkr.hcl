packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

source "googlecompute" "image" {
  image_name              = "${var.env}-${var.modules}-{{timestamp}}"
  machine_type            = "e2-small"
  disk_size               = 30
  source_image_family     = var.source_image
  network       = "uat-mrportal-network"
  subnetwork    = "uat-mrportal-subnet"
  ssh_username            = "packer"
  temporary_key_pair_type = "rsa"
  temporary_key_pair_bits = 2048
  zone                    = var.zone
  project_id              = var.project_id
  // tags  = ["packer-vm"]
  use_iap = true
  /*
  Assign a service account. https://console.cloud.google.com/security/iap. To do so, click "project" > "SSH and TCP resources" > "All Tunnel Resources" > "Add Member". Then add your service account and choose the role "IAP-secured Tunnel User" and add any conditions you may care about.
  */
  service_account_email = "mn-vm-svc-account@munna-rnd.iam.gserviceaccount.com"
}

build {
  sources = ["source.googlecompute.image"]
  provisioner "shell" {
    inline = [
      "echo Hello From ${source.type} ${source.name}"
    ]
  }
  provisioner "ansible" {
    playbook_file = "../ansible/${var.env}-${var.modules}.yaml"
    user = "packer"
    host_alias = "${var.env}'-'${var.modules}"
    ansible_env_vars = [
        "ANSIBLE_HOST_KEY_CHECKING=False",
        "ANSIBLE_SSH_ARGS='-o ForwardAgent=yes -o ControlMaster=auto -o ControlPersist=60s -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa'",
        "ANSIBLE_NOCOLOR=True"
      ]
  }
}