# ==========================================================
# modules/compute/main.tf
# Pure SSH Method (Linux Terraform -> SSH -> Windows Hyper-V)
# ==========================================================
resource "null_resource" "create_vm" {

  for_each = var.vms

  triggers = {
    name     = each.key
    memory   = each.value.memory
    cpu      = each.value.cpu
    vhd_path = each.value.vhd_path
    switch   = each.value.switch_name
  }

  provisioner "local-exec" {
    command = <<EOT
sshpass -p '${var.hyperv_password}' ssh \
-o StrictHostKeyChecking=no \
-o PreferredAuthentications=password \
-o PubkeyAuthentication=no \
-o NumberOfPasswordPrompts=1 \
${var.hyperv_user}@${var.hyperv_host} \
"powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"

\$ErrorActionPreference='Stop';

# Variables
\$vmName='${each.key}';
\$vhd='${each.value.vhd_path}';
\$switch='${each.value.switch_name}';
\$private='${var.private_switch}';

Write-Host 'Creating VM:' \$vmName;
Write-Host 'Public Switch:' \$pub;
Write-Host 'Private Switch:' \$pri;

if (!(Test-Path \$vhd)) { New-VHD -Path \$vhd -SizeBytes 30GB -Dynamic; }

if (!(Get-VM -Name \$vmName -ErrorAction SilentlyContinue)) {
 New-VM -Name \$vmName -MemoryStartupBytes ${each.value.memory}MB -Generation 2 -VHDPath \$vhd -SwitchName \$pub;
 Set-VMProcessor -VMName \$vmName -Count ${each.value.cpu};
 Add-VMNetworkAdapter -VMName \$vmName -SwitchName \$pri -Name PrivateNIC;
 Start-VM -Name \$vmName
 Write-Host 'VM Created Successfully'
}
else {
   Write-Host 'VM already exists'
}
\""
EOT
  }
}