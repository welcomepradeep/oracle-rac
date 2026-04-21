variable "rac1_name" {}
variable "rac2_name" {}

variable "memory" {}
variable "vhd_path" {}

variable "public_switch" {}
variable "private_switch" {}

variable "hyperv_host" {
  type = string
}

variable "hyperv_user" {
  type = string
}

variable "hyperv_password" {
  type = string
}

variable "vms" {
  type = map(any)
}

variable "memory" {
  type = number
}

variable "vhd_path" {
  type = string
}

variable "public_switch" {
  type = string
}

variable "private_switch" {
  type = string
}