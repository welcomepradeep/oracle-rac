resource "null_resource" "network" {
  provisioner "local-exec" {
    command = "powershell -ExecutionPolicy Bypass -File ../../scripts/create-switch.ps1"
  }
}