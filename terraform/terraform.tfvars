########################################
# RAC Node Names
########################################
rac1_name = "rac-node1"
rac2_name = "rac-node2"

########################################
# VM Configuration
########################################
memory   = 8192

vhd_path = "C:\\Pradeep\\CICDRUNNEROS\\oracle-linux.vhdx"

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
