param (
    [string]$vmName,
    [int]$memory,
    [string]$vhdPath,
    [string]$switchName
)

$vmPath = "C:\HyperV\VMs\$vmName"
$newVhd = "$vmPath\$vmName.vhdx"

New-Item -ItemType Directory -Path $vmPath -Force | Out-Null
Copy-Item $vhdPath $newVhd -Force

New-VM -Name $vmName -MemoryStartupBytes (${memory}MB) -VHDPath $newVhd -Generation 2 -Path $vmPath

Connect-VMNetworkAdapter -VMName $vmName -SwitchName $switchName

Start-VM -Name $vmName