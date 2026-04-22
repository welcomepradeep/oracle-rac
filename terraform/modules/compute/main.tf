resource "null_resource" "create_vm" {

  for_each = var.vms

  triggers = {
    name       = each.key
    memory     = each.value.memory
    cpu        = each.value.cpu
    vhd_path   = each.value.vhd_path
    switch     = each.value.switch_name
  }

  provisioner "local-exec" {
    command = <<EOT
pwsh -Command "
Invoke-Command -ComputerName ${var.hyperv_host} -Credential (New-Object System.Management.Automation.PSCredential('${var.hyperv_user}', (ConvertTo-SecureString '${var.hyperv_password}' -AsPlainText -Force))) -ScriptBlock {

    if (-not (Get-VM -Name '${each.key}' -ErrorAction SilentlyContinue)) {

        New-VM -Name '${each.key}' -MemoryStartupBytes ${each.value.memory}MB -Generation 2 -VHDPath '${each.value.vhd_path}' -SwitchName '${each.value.switch_name}'

        Set-VMProcessor -VMName '${each.key}' -Count ${each.value.cpu}

        # Add private adapter for RAC interconnect
        Add-VMNetworkAdapter -VMName '${each.key}' -SwitchName '${var.private_switch}' -Name "PrivateNIC"
    }
}"
EOT
  }
}