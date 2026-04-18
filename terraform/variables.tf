########################################
# RAC Node Names
########################################
variable "rac1_name" {
  default = "rac1"
}

variable "rac2_name" {
  default = "rac2"
}

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
variable "public_switch" {
  description = "Public network switch"
  default     = "ExternalSwitch"
}

variable "private_switch" {
  description = "Private RAC interconnect"
  default     = "RAC-Private"
}

########################################
# Shared Storage (ASM Disks)
########################################
variable "shared_disks" {
  description = "Shared disks for Oracle RAC (ASM)"
  
  type = list(object({
    name = string
    size = number  # Size in GB
  }))

  default = [
    {
      name = "ocr.vhdx"
      size = 10
    },
    {
      name = "data.vhdx"
      size = 10
    }
  ]
}

########################################
# Disk Base Path
########################################
variable "disk_base_path" {
  description = "Location where shared disks will be created"
  default     = "C:\\Pradeep\\CICDRUNNEROS"
}