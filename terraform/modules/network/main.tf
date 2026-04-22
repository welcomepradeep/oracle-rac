resource "null_resource" "create_switch" {

  triggers = {
    switch_name  = var.switch_name
    adapter_name = var.adapter_name
  }

  provisioner "local-exec" {
    command = <<EOT
pwsh -Command "
Invoke-Command -ComputerName ${var.hyperv_host} -Credential (New-Object System.Management.Automation.PSCredential('${var.hyperv_user}', (ConvertTo-SecureString '${var.hyperv_password}' -AsPlainText -Force))) -ScriptBlock {
    if (-not (Get-VMSwitch -Name '${var.switch_name}' -ErrorAction SilentlyContinue)) {
        New-VMSwitch -Name '${var.switch_name}' -NetAdapterName '${var.adapter_name}' -AllowManagementOS $true
    }
}"
EOT
  }
}