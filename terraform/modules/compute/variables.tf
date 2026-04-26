variable "vms" {
  type = map(object({
    memory      = number
    cpu         = number
    vhd_path    = string
    switch_name = string
    iso_path    = string
  }))
}

variable "public_switch" {
  type = string
  default = "ExternalSwitch"
}

variable "private_switch" {
  type = string
  default = "InternalSwitch"
}

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