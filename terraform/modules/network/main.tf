resource "null_resource" "network" {

  triggers = {
    switch_name = var.switch_name
    script_hash = filemd5("${path.root}/scripts/create-switch.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
      pwsh -ExecutionPolicy Bypass -File "${path.root}/scripts/create-switch.ps1" `
        -SwitchName "${var.switch_name}" `
        -AdapterName "${var.adapter_name}" `
        -AllowManagementOS "${var.allow_management_os}"
    EOT
  }
}