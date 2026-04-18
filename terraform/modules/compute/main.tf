resource "null_resource" "vm" {
  for_each = var.vms

  provisioner "remote-exec" {
    inline = [
      "powershell -ExecutionPolicy Bypass -File C:\\scripts\\create-vm.ps1 ..."
    ]

    connection {
      type     = "winrm"
      host     = var.hyperv_host
      user     = var.hyperv_user
      password = var.hyperv_password
      https    = false
      insecure = true
    }
  }
}