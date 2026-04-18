  vms = {
    rac1 = {
      memory      = 8192
      cpu         = 2
      vhd_path    = "C:\\HyperV\\rac1.vhdx"
      switch_name = module.network.switch_name
    }

    rac2 = {
      memory      = 8192
      cpu         = 2
      vhd_path    = "C:\\HyperV\\rac2.vhdx"
      switch_name = module.network.switch_name
    }

  }

  depends_on = [
    module.network,
    module.storage
  ]
