resource "null_resource" "network" {

  triggers = {
    script_hash = filemd5("${path.root}/scripts/create-switch.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
      pwsh -ExecutionPolicy Bypass -File "${path.root}/scripts/create-switch.ps1"
    EOT
  }
}