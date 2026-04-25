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
  type = string
  default = "ExternalSwitch"
}

variable "private_switch" {
  type = string
}

variable "adapter_name" {
  type = string
  default = "Wi-Fi"
}

########################################
# Shared Storage (ASM Disks)
########################################
variable "shared_disks" {
  description = "List of shared disks"
  type = list(object({
    name = string
    size = number
  }))
}

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