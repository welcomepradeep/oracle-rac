output "disk_path" {
  description = "Full path of created disk"
  value       = "${var.disk_path}/${var.disk_name}.vhdx"
}