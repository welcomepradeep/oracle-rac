########################################
# RAC Node Names
########################################
rac1_name = "rac1"
rac2_name = "rac2"

########################################
# VM Configuration
########################################
vms = {
  rac1 = {
    memory      = 8192
    cpu         = 2
    vhd_path    = "C:\\Pradeep\\CICDRUNNEROS\\rac1.vhdx"
    switch_name = "ExternalSwitch"
  }

  rac2 = {
    memory      = 8192
    cpu         = 2
    vhd_path    = "C:\\Pradeep\\CICDRUNNEROS\\rac2.vhdx"
    switch_name = "ExternalSwitch"
  }

}

########################################
# Network Configuration
########################################
public_switch  = "ExternalSwitch"
private_switch = "RAC-Private"

########################################
# Shared Storage (ASM Disks)
########################################
shared_disks = [
  {
    name = "ocr.vhdx"
    size = 10
  },
  {
    name = "data.vhdx"
    size = 10
  }
]

########################################
# Disk Base Path
########################################
disk_base_path = "C:\\HyperV\\Disks"