variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    memory      = number
    cpu         = number
    vhd_path    = string
    switch_name = string
  }))
}