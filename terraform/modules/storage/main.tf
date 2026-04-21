resource "null_resource" "shared_disks" {
  provisioner "local-exec" {
    command = "powershell -ExecutionPolicy Bypass -File ../../scripts/create-disk.ps1"
  }
}