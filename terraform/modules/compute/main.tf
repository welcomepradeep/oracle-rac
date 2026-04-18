resource "null_resource" "rac_nodes" {

  for_each = {
    rac1 = var.rac1_name
    rac2 = var.rac2_name
  }

  triggers = {
    vm_name     = each.value
    memory      = var.memory
    vhd_path    = var.vhd_path
    switch_name = var.public_switch
    script_hash = filemd5("${path.root}/scripts/create-vm.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
      pwsh -ExecutionPolicy Bypass -File "${path.root}/scripts/create-vm.ps1" `
        -vmName "${each.value}" `
        -memory ${var.memory} `
        -vhdPath "${var.vhd_path}" `
        -switchName "${var.public_switch}"
    EOT
  }
}