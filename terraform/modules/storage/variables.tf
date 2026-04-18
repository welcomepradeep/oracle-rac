variable "disk_name" {
  description = "Disk name"
  type        = string
}

variable "disk_path" {
  description = "Path where VHD will be created"
  type        = string
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
}