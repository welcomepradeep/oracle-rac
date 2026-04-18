resource "null_resource" "vm" {

  for_each = var.vms

  triggers = {
    vm_name        = each.key
    memory         = each.value.memory
    cpu            = each.value.cpu
    vhd_path       = each.value.vhd_path
    switch_name    = each.value.switch_name
    script_hash    = filemd5("${path.root}/scripts/create-vm.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
      pwsh -ExecutionPolicy Bypass -File "${path.root}/scripts/create-vm.ps1" \
        -vmName "${each.key}" \
        -memory ${each.value.memory} \
        -cpu ${each.value.cpu} \
        -vhdPath "${each.value.vhd_path}" \
        -switchName "${each.value.switch_name}"
    EOT
  }
}