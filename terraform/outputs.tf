########################################
# COMPUTE OUTPUTS
########################################
output "vm_names" {
  description = "List of RAC VM names"
  value       = module.compute.vm_names
}

output "vm_details" {
  description = "Detailed VM configuration"
  value       = module.compute.vm_details
}

output "compute_status" {
  description = "Compute provisioning status"
  value       = module.compute.compute_status
}

########################################
# NETWORK OUTPUTS
########################################
output "network" {
  description = "Network configuration details"
  value       = module.network.network_status
}

########################################
# STORAGE OUTPUTS
########################################
output "disk_paths" {
  description = "Paths of shared ASM disks"
  value       = module.storage.disk_paths
}

output "disk_details" {
  description = "Detailed shared disk configuration"
  value       = module.storage.disk_details
}

output "storage_status" {
  description = "Storage provisioning status"
  value       = module.storage.storage_status
}

########################################
# CONSOLIDATED SUMMARY (VERY USEFUL)
########################################
output "rac_environment_summary" {
  description = "Complete RAC infrastructure summary"

  value = {
    vms     = module.compute.vm_details
    network = module.network.network_status
    storage = module.storage.disk_details
  }
}