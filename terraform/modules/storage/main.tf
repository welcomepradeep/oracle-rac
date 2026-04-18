resource "null_resource" "storage" {

  triggers = {
    disk_name   = var.disk_name
    disk_size   = var.disk_size_gb
    script_hash = filemd5("${path.root}/scripts/create-disk.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
      pwsh -ExecutionPolicy Bypass -File "${path.root}/scripts/create-disk.ps1" `
        -DiskName "${var.disk_name}" `
        -DiskPath "${var.disk_path}" `
        -DiskSizeGB ${var.disk_size_gb}
    EOT
  }
}