resource "null_resource" "create_switch" {

  provisioner "remote-exec" {
    inline = [
      "powershell -ExecutionPolicy Bypass -File C:\\scripts\\create-switch.ps1 -switchName ${var.switch_name} -adapterName ${var.adapter_name}"
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