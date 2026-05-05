param (
    [string]$vmName,
    [int]$memory,
    [string]$vhdPath,
    [string]$switchName,
    [string]$isoPath,
    [int]$cpu = 2,
    [string]$privateSwitch = "InternalSwitch",
    [string]$hostname,
    [string]$publicIP,
    [string]$privateIP,
    [string]$ksFile
)

$ErrorActionPreference = "Stop"

Write-Host "===================================="
Write-Host "Starting Silent VM Build : $vmName"
Write-Host "Memory        : $memory MB"
Write-Host "CPU           : $cpu"
Write-Host "VHD Path      : $vhdPath"
Write-Host "ISO Path      : $isoPath"
Write-Host "Public Switch : $switchName"
Write-Host "Private Switch: $privateSwitch"
Write-Host "Hostname      : $hostname"
Write-Host "Public IP     : $publicIP"
Write-Host "Private IP    : $privateIP"
Write-Host "Kickstart     : $ksFile"
Write-Host "===================================="

# ---------------------------------------------------
# Validate Inputs
# ---------------------------------------------------

# Validate Public Switch
$pub = Get-VMSwitch -Name $switchName -ErrorAction SilentlyContinue
if (-not $pub) {
    throw "Public switch '$switchName' not found."
}

# Validate ISO file
if (!(Test-Path $isoPath)) {
    throw "ISO file '$isoPath' not found."
}

# ---------------------------------------------------
# Kickstart Validation (FIXED)
# ---------------------------------------------------

# If ksFile is just filename, build full path
if ($ksFile -notmatch "^[A-Za-z]:\\") {
    $ksFile = "C:\Terraform\kickstart\$ksFile"
}

Write-Host "Resolved Kickstart Path: $ksFile"

if (!(Test-Path $ksFile)) {
    throw "Kickstart file NOT found at: $ksFile"
}

# ---------------------------------------------------
# VM Creation
# ---------------------------------------------------

# Check if VM already exists
$vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue

if (-not $vm) {

    # Create VHD if missing
    if (!(Test-Path $vhdPath)) {
        Write-Host "Creating VHD..."
        New-VHD -Path $vhdPath -SizeBytes 30GB -Dynamic
    }

    # Create VM
    Write-Host "Creating VM..."
    New-VM -Name $vmName -Generation 2 `
        -MemoryStartupBytes ($memory * 1MB) `
        -VHDPath $vhdPath `
        -SwitchName $switchName

    Set-VMFirmware -VMName $vmName -EnableSecureBoot Off

    # Configure CPU
    Set-VMProcessor -VMName $vmName -Count $cpu

    # Attach ISO
    Add-VMDvdDrive -VMName $vmName -Path $isoPath

    # Boot from ISO
    $dvd = Get-VMDvdDrive -VMName $vmName
    Set-VMFirmware -VMName $vmName -FirstBootDevice $dvd

    # Add Private NIC
    $pri = Get-VMSwitch -Name $privateSwitch -ErrorAction SilentlyContinue
    if ($pri) {
        Add-VMNetworkAdapter -VMName $vmName -SwitchName $privateSwitch -Name "PrivateNIC"
        Write-Host "Private NIC added"
    }
    else {
        Write-Host "Private switch '$privateSwitch' not found. Skipping."
    }

    # Start VM
    Start-VM -Name $vmName

    Write-Host "VM $vmName created successfully"
}
else {
    Write-Host "VM $vmName already exists"
}

Write-Host "Current VM Status:"
Get-VM -Name $vmName