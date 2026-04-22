output "vm_names" {
  description = "Names of created VMs"
  value       = keys(var.vms)
}

output "vm_details" {
  description = "Detailed VM configuration"

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

output "network_assignment" {
  description = "VM network configuration"

  value = {
    public_switch  = var.public_switch
    private_switch = var.private_switch
  }
}

output "compute_status" {
  description = "Compute provisioning status"

  value = {
    vm_count = length(var.vms)
    status   = "created"
  }
}

