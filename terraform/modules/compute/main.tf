module "compute" {
  source = "./modules/compute"

  rac1_name      = "rac1"
  rac2_name      = "rac2"
  memory         = 8192
  vhd_path       = "C:\\HyperV\\base.vhdx"
  public_switch  = module.network.switch_name

  depends_on = [
    module.network,
    module.storage
  ]
}