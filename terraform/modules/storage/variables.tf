variable "shared_disks" {
  type = list(object({
    name = string
    size = number
  }))
}

variable "disk_base_path" {
  type = string
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