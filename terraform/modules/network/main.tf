resource "null_resource" "create_switch" {

  triggers = {
    switch_name  = var.switch_name
    adapter_name = var.adapter_name
    script_hash  = filemd5("${path.root}/scripts/create-switch.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
      pwsh -ExecutionPolicy Bypass -File "${path.root}/scripts/create-switch.ps1" \
        -switchName "${var.switch_name}" \
        -adapterName "${var.adapter_name}"
    EOT
  }
}