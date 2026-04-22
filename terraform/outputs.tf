########################################
# VM SUMMARY
########################################
output "vm_summary" {
  description = "Summary of all RAC VMs"

  value = {
    for vm_name, vm in var.vms :
    vm_name => {
      memory_mb   = vm.memory
      cpu         = vm.cpu
      vhd_path    = vm.vhd_path
      switch_name = vm.switch_name
    }
  }
}

########################################
# VM NAMES
########################################
output "vm_names" {
  description = "List of VM names"
  value       = keys(var.vms)
}

########################################
# NETWORK INFO
########################################
output "network_config" {
  description = "Network configuration details"

  value = {
    public_switch  = var.public_switch
    private_switch = var.private_switch
    adapter_name   = var.adapter_name
  }
}

########################################
# SHARED DISKS
########################################
output "shared_disks" {
  description = "ASM shared disks configuration"

  value = [
    for disk in var.shared_disks : {
      name = disk.name
      size = disk.size
      path = "${var.disk_base_path}\\${disk.name}"
    }
  ]
}
########################################
# HYPERV HOST INFO
########################################
output "hyperv_host" {
  description = "Hyper-V host used for deployment"
  value       = var.hyperv_host
}