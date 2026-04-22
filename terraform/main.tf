########################################
# NETWORK
########################################
module "network" {
  source = "./modules/network"

  switch_name  = var.public_switch
  adapter_name = var.adapter_name

  hyperv_host     = var.hyperv_host
  hyperv_user     = var.hyperv_user
  hyperv_password = var.hyperv_password
}

########################################
# STORAGE (ASM DISKS)
########################################
module "storage" {
  source = "./modules/storage"

  shared_disks   = var.shared_disks
  disk_base_path = var.disk_base_path

  hyperv_host     = var.hyperv_host
  hyperv_user     = var.hyperv_user
  hyperv_password = var.hyperv_password
}

########################################
# COMPUTE (VM CREATION)
########################################
module "compute" {
  source = "./modules/compute"

  vms = var.vms

  public_switch  = var.public_switch
  private_switch = var.private_switch

  hyperv_host     = var.hyperv_host
  hyperv_user     = var.hyperv_user
  hyperv_password = var.hyperv_password
}