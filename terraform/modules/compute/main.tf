resource "null_resource" "vm" {
  for_each = var.vms

  triggers = {
    vm_name = each.key
  }

  provisioner "remote-exec" {
    inline = [
      "powershell -ExecutionPolicy Bypass -File C:\\scripts\\create-vm.ps1 " 
      + "-vm_name ${each.key} "
      + "-memory ${each.value.memory} "
      + "-cpu ${each.value.cpu} "
      + "-vhd_path ${each.value.vhd_path} "
      + "-switch_name ${each.value.switch_name}"
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