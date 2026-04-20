########################################
# RAC Node Names
########################################
variable "rac1_name" {
  type    = string
  default = "rac1"
}

variable "rac2_name" {
  type    = string
  default = "rac2"
}

########################################
# VM Configuration
########################################
variable "vms" {
  description = "VM configuration for RAC nodes"

  type = map(object({
    memory      = number
    cpu         = number
    vhd_path    = string
    switch_name = string
  }))
}

########################################
# Network Configuration
########################################
variable "public_switch" {
  description = "Public network switch"
  type        = string
}

variable "private_switch" {
  description = "Private RAC interconnect"
  type        = string
}

########################################
# Shared Storage (ASM Disks)
########################################
variable "shared_disks" {
  description = "Shared disks for Oracle RAC (ASM)"

  type = list(object({
    name = string
    size = number
  }))
}

########################################
# Disk Base Path
########################################
variable "disk_base_path" {
  description = "Location where shared disks will be created"
  type        = string
}

########################################
# Hyper-V Connection
########################################
variable "hyperv_host" {
  type = string
}

variable "hyperv_user" {
  type = string
}

variable "hyperv_password" {
  type      = string
  sensitive = true
}
