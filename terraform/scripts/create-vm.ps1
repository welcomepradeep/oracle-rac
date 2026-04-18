param (
    [string]$vmName,
    [int]$memory,
    [string]$vhdPath,
    [string]$switchName
)

$vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue

if (-not $vm) {
    New-VM -Name $vmName `
        -MemoryStartupBytes (${memory}MB) `
        -VHDPath $vhdPath `
        -SwitchName $switchName

    Start-VM -Name $vmName
    Write-Host "VM $vmName created"
} else {
    Write-Host "VM $vmName already exists"
}