# ==========================================================
# modules/network/main.tf
# Pure SSH Method (Linux Terraform -> SSH -> Windows Hyper-V)
# ==========================================================
resource "null_resource" "create_switch" {

  triggers = {
    switch_name  = var.switch_name
    adapter_name = var.adapter_name
  }

  provisioner "local-exec" {
    command = <<EOT
ssh -o IdentitiesOnly=yes ${var.hyperv_user}@${var.hyperv_host} "powershell -NoProfile -Command \"
if (-not (Get-VMSwitch -Name '${var.switch_name}' -ErrorAction SilentlyContinue)) {
New-VMSwitch -Name '${var.switch_name}' -NetAdapterName '${var.adapter_name}' -AllowManagementOS \$true;
}
\""
EOT
  }
}