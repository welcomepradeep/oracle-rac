module "network" {
  source = "./modules/network"

  switch_name  = var.public_switch
  adapter_name = "Ethernet"
}

module "storage" {
  source = "./modules/storage"
}

module "compute" {
  source = "./modules/compute"

  rac1_name   = var.rac1_name
  rac2_name   = var.rac2_name

  memory      = var.memory
  vhd_path    = var.vhd_path

  public_switch  = var.public_switch
  private_switch = var.private_switch
}