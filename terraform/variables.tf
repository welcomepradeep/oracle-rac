########################################
# RAC Node Names
########################################
variable "rac1_name" {
  default = "rac-node1"
}

variable "rac2_name" {
  default = "rac-node2"
}

########################################
# VM Configuration
########################################
variable "memory" {
  description = "Memory in MB"
  default     = 8192
}

variable "vhd_path" {
  description = "Base OS VHDX path"
  default     = "C:\\Pradeep\\CICDRUNNEROS\\oracle-linux.vhdx"
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