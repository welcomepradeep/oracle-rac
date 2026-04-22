output "switch_name" {
  description = "Name of the created/existing Hyper-V switch"
  value       = var.switch_name
}

output "adapter_name" {
  description = "Adapter used for the switch"
  value       = var.adapter_name
}

output "network_status" {
  description = "Network provisioning status"
  value = {
    switch  = var.switch_name
    adapter = var.adapter_name
    status  = "configured"
  }
}
