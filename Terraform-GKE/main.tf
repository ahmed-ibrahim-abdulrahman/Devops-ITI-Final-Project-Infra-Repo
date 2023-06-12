module "gke-cluster" {
  source     = "./gke_cluster"
  name       = "gke-cluster"
  network    = module.vpc.vpc_name
  subnetwork = module.subnet.subnet_name

  name-node = "cluster-nodes"

}




module "iap" {
  source       = "./iap"
  account_id   = "iap-sa"
  display_name = "iap-sa"
  network      = module.vpc.vpc_name


}



module "jump_host" {
  source       = "./jump_host"
  subnetwork   = module.subnet.subnet_name
  name         = "jump-host"
  machine_type = "e2-medium"
  network      = module.vpc.vpc_name

}



module "nat" {
  source                 = "./nat_gateway"
  subnetwork             = module.subnet.subnet_name
  nat_ip_allocate_option = "AUTO_ONLY"
  network                = module.vpc.vpc_name



  name = module.subnet.subnet_id

}




module "subnet" {
  source  = "./subnet"
  name    = "subnet-t"
  network = module.vpc.vpc_name

}

module "vpc" {
  source                  = "./vpc"
  name                    = "vpc-t"
  auto_create_subnetworks = false
}




