# ==========================================================
# modules/storage/main.tf
# Pure SSH Method (Linux Terraform -> SSH -> Windows Hyper-V)
# ==========================================================
resource "null_resource" "create_disks" {

  for_each = {
    for disk in var.shared_disks : disk.name => disk
  }

  triggers = {
    name = each.value.name
    size = each.value.size
    path = var.disk_base_path
  }

  provisioner "local-exec" {
    command = <<EOT
ssh ${var.hyperv_user}@${var.hyperv_host} powershell -Command "
\$diskPath='${var.disk_base_path}\\${each.value.name}'

if (-not (Test-Path \$diskPath)) {
    New-VHD `
      -Path \$diskPath `
      -SizeBytes (${each.value.size}GB) `
      -Dynamic
}
"
EOT
  }
}