# ==========================================================
# modules/compute/main.tf
# Production Grade Version
# Linux Terraform Runner -> Copy PS1 -> Windows Hyper-V Host
# ==========================================================

resource "null_resource" "create_vm" {

  for_each = var.vms

  triggers = {
    name       = each.key
    memory     = each.value.memory
    cpu        = each.value.cpu
    vhd_path   = each.value.vhd_path
    switch     = each.value.switch_name
    iso_path   = each.value.iso_path
    hostname   = each.value.hostname
    public_ip  = each.value.public_ip
    private_ip = each.value.private_ip
    ks_file    = each.value.ks_file
    script     = filemd5("${path.root}/scripts/create-vm.ps1")
  }

  provisioner "local-exec" {

    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
set -e
echo "========================================"
echo "Starting VM creation: ${each.key}"
echo "========================================"

# Variables
HOST="winrmadmin@192.168.56.1"
PASS="winrm@123"

SCRIPT_LOCAL="${path.root}/scripts/create-vm.ps1"
KS_LOCAL="${path.root}/kickstart/${each.key}.cfg"

SCRIPT_REMOTE="C:/Terraform/scripts/create-vm.ps1"
KS_REMOTE="C:/Terraform/kickstart/${each.key}.cfg"

# ----------------------------------------
# Validate local files
# ----------------------------------------
echo "Validating local files..."

if [ ! -f "$SCRIPT_LOCAL" ]; then
  echo "ERROR: Script not found: $SCRIPT_LOCAL"
  exit 1
fi

if [ ! -f "$KS_LOCAL" ]; then
  echo "ERROR: Kickstart not found: $KS_LOCAL"
  exit 1
fi

# ----------------------------------------
# Step 1 - Create remote folder
# ----------------------------------------
sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $HOST \
"powershell -ExecutionPolicy Bypass -Command \"
New-Item -ItemType Directory -Force -Path C:\\Terraform\\scripts | Out-Null; 
New-Item -ItemType Directory -Force -Path C:\\Terraform\\kickstart | Out-Null\""

# ----------------------------------------
# Step 2 - Copy script to Windows host
# ----------------------------------------
echo "Copying files..."

sshpass -p "$PASS" scp -o StrictHostKeyChecking=no \
"$SCRIPT_LOCAL" \
$HOST:/$SCRIPT_REMOTE

sshpass -p "$PASS" scp -o StrictHostKeyChecking=no \
"$KS_LOCAL" \
$HOST:/$KS_REMOTE

# ------------------------------------------------
# Step 3 - Copy Kickstart file
# ------------------------------------------------
sshpass -p '${var.hyperv_password}' scp \
-o StrictHostKeyChecking=no \
${path.module}/kickstart/${each.key}.cfg \
${var.hyperv_user}@${var.hyperv_host}:/C:/Terraform/kickstart/${each.value.ks_file}

# ----------------------------------------
# Step 4 - Execute script remotely
# ----------------------------------------
sshpass -p '${var.hyperv_password}' ssh -o StrictHostKeyChecking=no ${var.hyperv_user}@${var.hyperv_host} "powershell -Command \"New-Item -ItemType Directory -Force -Path C:\\Terraform\\scripts | Out-Null\""

sshpass -p '${var.hyperv_password}' scp -o StrictHostKeyChecking=no ${path.root}/scripts/create-vm.ps1 ${var.hyperv_user}@${var.hyperv_host}:/C:/Terraform/scripts/create-vm.ps1

sshpass -p '${var.hyperv_password}' ssh -o StrictHostKeyChecking=no ${var.hyperv_user}@${var.hyperv_host} "powershell -ExecutionPolicy Bypass -File C:\\Terraform\\scripts\\create-vm.ps1 -vmName ${each.key} -memory ${each.value.memory} -vhdPath ${each.value.vhd_path} -switchName ${each.value.switch_name} -isoPath ${each.value.iso_path} -cpu ${each.value.cpu} -privateSwitch ${var.private_switch} -hostname ${each.value.hostname} -publicIP ${each.value.public_ip} -privateIP ${each.value.private_ip} -ksFile ${each.value.ks_file}"
EOT
  }
}