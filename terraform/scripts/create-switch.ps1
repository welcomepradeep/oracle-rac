# Create switches
New-VMSwitch -Name "ExternalSwitch" -NetAdapterName "Realtek 8852CE WiFi 6E PCI-E NIC" -AllowManagementOS $true
New-VMSwitch -Name "RAC-Private" -SwitchType Internal

# Create VMs
New-VM -Name "rac1" -MemoryStartupBytes 8GB -SwitchName "ExternalSwitch"
New-VM -Name "rac2" -MemoryStartupBytes 8GB -SwitchName "ExternalSwitch"

# Add private network
Add-VMNetworkAdapter -VMName "rac1" -SwitchName "RAC-Private"
Add-VMNetworkAdapter -VMName "rac2" -SwitchName "RAC-Private"