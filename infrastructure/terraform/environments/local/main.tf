module "k3d_cluster" {
  source = "../../modules/k3d"
}

provider "k3d" {}
