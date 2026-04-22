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
pwsh -Command "
Invoke-Command -ComputerName ${var.hyperv_host} -Credential (New-Object System.Management.Automation.PSCredential('${var.hyperv_user}', (ConvertTo-SecureString '${var.hyperv_password}' -AsPlainText -Force))) -ScriptBlock {
    $diskPath = '${var.disk_base_path}\\${each.value.name}'
    if (-not (Test-Path $diskPath)) {
        New-VHD -Path $diskPath -SizeBytes (${each.value.size}GB) -Dynamic
    }
}"
EOT
  }
}