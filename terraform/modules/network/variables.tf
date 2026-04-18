variable "switch_name" {
  description = "Hyper-V virtual switch name"
  type        = string
}

variable "adapter_name" {
  description = "Physical adapter name"
  type        = string
}

variable "allow_management_os" {
  description = "Allow management OS to share adapter"
  type        = bool
  default     = true
}