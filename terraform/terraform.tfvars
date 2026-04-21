rac1_name = "rac1"
rac2_name = "rac2"

vms = {
  rac1 = {
    memory      = 8192
    cpu         = 2
    vhd_path    = "C:\\HyperV\\Disks\\rac1.vhdx"
    switch_name = "ExternalSwitch"
  }

  rac2 = {
    memory      = 8192
    cpu         = 2
    vhd_path    = "C:\\HyperV\\Disks\\rac2.vhdx"
    switch_name = "ExternalSwitch"
  }
}

public_switch  = "ExternalSwitch"
private_switch = "RAC-Private"

adapter_name = "eth1"
switch_name  = "rac-switch"

disk_name    = "rac-disk1"
disk_path    = "C:\\HyperV\\Disks"
disk_size_gb = 10

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

disk_base_path = "C:\\HyperV\\Disks"

hyperv_host     = "192.168.56.1"
hyperv_user     = "winrmadmin"
hyperv_password = "cloud_login_83"