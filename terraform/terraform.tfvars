vms = {
  rac1 = {
    memory      = 8192
    cpu         = 2
    vhd_path    = "C:\\HyperV\\Disks\\rac1.vhdx"
    switch_name = "ExternalSwitch"
    iso_path    = "C:\\OracleLinux8.4\\OracleLinux-R8-U4-x86_64-dvd.iso"
    hostname    = "rac1.oracle.com"
    public_ip   = "192.168.0.101"
    private_ip  = "10.10.10.11"
    ks_file     = "rac1.cfg"
  }

  rac2 = {
    memory      = 8192
    cpu         = 2
    vhd_path    = "C:\\HyperV\\Disks\\rac2.vhdx"
    switch_name = "ExternalSwitch"
    iso_path    = "C:\\OracleLinux8.4\\OracleLinux-R8-U4-x86_64-dvd.iso"
    hostname    = "rac2.oracle.com"
    public_ip   = "192.168.0.102"
    private_ip  = "10.10.10.12"
    ks_file     = "rac2.cfg"
  }
}

public_switch  = "ExternalSwitch"
private_switch = "InternalSwitch"
adapter_name   = "PrivateAdapter"

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
hyperv_password = "winrm@123"