variable "rac1_name" {
  type = string
}

variable "rac2_name" {
  type = string
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