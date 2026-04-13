resource "null_resource" "rac1" {
  provisioner "local-exec" {
    command = "powershell -File ../../scripts/create-vm.ps1 -vmName ${var.rac1_name} -memory ${var.memory} -vhdPath ${var.vhd_path} -switchName ${var.public_switch}"
  }
}

resource "null_resource" "rac2" {
  provisioner "local-exec" {
    command = "powershell -File ../../scripts/create-vm.ps1 -vmName ${var.rac2_name} -memory ${var.memory} -vhdPath ${var.vhd_path} -switchName ${var.public_switch}"
  }
}