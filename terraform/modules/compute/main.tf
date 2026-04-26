# ==========================================================
# modules/compute/main.tf
# Production Grade Version
# Linux Terraform Runner -> Copy PS1 -> Windows Hyper-V Host
# ==========================================================

resource "null_resource" "create_vm" {

  for_each = var.vms

  triggers = {
    name     = each.key
    memory   = each.value.memory
    cpu      = each.value.cpu
    vhd_path = each.value.vhd_path
    switch   = each.value.switch_name
    iso_path = each.value.iso_path
    script   = filemd5("${path.root}/scripts/create-vm.ps1")
  }

  provisioner "local-exec" {
    command = <<EOT
# ----------------------------------------
# Step 1 - Create remote folder
# ----------------------------------------
sshpass -p '${var.hyperv_password}' ssh \
-o StrictHostKeyChecking=no \
-o PreferredAuthentications=password \
-o PubkeyAuthentication=no \
${var.hyperv_user}@${var.hyperv_host} \
"powershell -Command \"New-Item -ItemType Directory -Force -Path C:\\Terraform\\scripts | Out-Null\""

# ----------------------------------------
# Step 2 - Copy script to Windows host
# ----------------------------------------
sshpass -p '${var.hyperv_password}' scp \
-o StrictHostKeyChecking=no \
${path.root}/scripts/create-vm.ps1 \
${var.hyperv_user}@${var.hyperv_host}:/C:/Terraform/scripts/create-vm.ps1

# ----------------------------------------
# Step 3 - Execute script remotely
# ----------------------------------------
sshpass -p '${var.hyperv_password}' ssh -o StrictHostKeyChecking=no ${var.hyperv_user}@${var.hyperv_host} "powershell -Command \"New-Item -ItemType Directory -Force -Path C:\\Terraform\\scripts | Out-Null\""

sshpass -p '${var.hyperv_password}' scp -o StrictHostKeyChecking=no ${path.root}/scripts/create-vm.ps1 ${var.hyperv_user}@${var.hyperv_host}:/C:/Terraform/scripts/create-vm.ps1

sshpass -p '${var.hyperv_password}' ssh -o StrictHostKeyChecking=no ${var.hyperv_user}@${var.hyperv_host} "powershell -ExecutionPolicy Bypass -File C:\\Terraform\\scripts\\create-vm.ps1 -vmName ${each.key} -memory ${each.value.memory} -vhdPath ${each.value.vhd_path} -switchName ${each.value.switch_name} -isoPath ${each.value.iso_path} -cpu ${each.value.cpu} -privateSwitch ${var.private_switch}"
EOT
  }
}