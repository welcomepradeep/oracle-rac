output "disk_paths" {
  description = "Full paths of created shared disks"

  value = [
    for disk in var.shared_disks :
    "${var.disk_base_path}\\${disk.name}"
  ]
}

output "disk_details" {
  description = "Detailed shared disk configuration"

  value = [
    for disk in var.shared_disks : {
      name = disk.name
      size = disk.size
      path = "${var.disk_base_path}\\${disk.name}"
    }
  ]
}

output "storage_status" {
  description = "Storage provisioning status"

  value = {
    disk_count = length(var.shared_disks)
    base_path  = var.disk_base_path
    status     = "created"
  }
}