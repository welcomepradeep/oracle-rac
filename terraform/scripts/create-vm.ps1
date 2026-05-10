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
    [string]$privateIP
)

$ErrorActionPreference = "Stop"

Write-Host "===================================="
Write-Host "Starting Silent VM Build : $vmName"
Write-Host "===================================="

Write-Host "VM Name        : $vmName"
Write-Host "Memory         : $memory MB"
Write-Host "CPU            : $cpu"
Write-Host "VHD Path       : $vhdPath"
Write-Host "ISO Path       : $isoPath"
Write-Host "Public Switch  : $switchName"
Write-Host "Private Switch : $privateSwitch"
Write-Host "Hostname       : $hostname"
Write-Host "Public IP      : $publicIP"
Write-Host "Private IP     : $privateIP"

# ---------------------------------------------------
# Validate Public Switch
# ---------------------------------------------------

$pub = Get-VMSwitch -Name $switchName -ErrorAction SilentlyContinue

if (-not $pub) {
    throw "Public switch '$switchName' not found."
}

Write-Host "Public switch verified."

# ---------------------------------------------------
# Validate Custom ISO
# ---------------------------------------------------

if (!(Test-Path $isoPath)) {
    throw "Custom ISO file not found: $isoPath"
}

Write-Host "Custom ISO verified."

# ---------------------------------------------------
# Check if VM already exists
# ---------------------------------------------------

$vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue

if (-not $vm) {

    Write-Host "VM does not exist. Creating new VM..."

    # ---------------------------------------------------
    # Create VHD if missing
    # ---------------------------------------------------

    if (!(Test-Path $vhdPath)) {

        $vhdFolder = Split-Path $vhdPath

        if (!(Test-Path $vhdFolder)) {
            Write-Host "Creating VHD folder: $vhdFolder"

            New-Item `
                -ItemType Directory `
                -Path $vhdFolder `
                -Force | Out-Null
        }

        Write-Host "Creating VHD..."

        New-VHD `
            -Path $vhdPath `
            -SizeBytes 30GB `
            -Dynamic | Out-Null

        Write-Host "VHD created successfully."
    }
    else {
        Write-Host "VHD already exists."
    }

    # ---------------------------------------------------
    # Create VM
    # ---------------------------------------------------

    Write-Host "Creating VM..."

    New-VM `
        -Name $vmName `
        -Generation 2 `
        -MemoryStartupBytes ($memory * 1MB) `
        -VHDPath $vhdPath `
        -SwitchName $switchName | Out-Null

    Write-Host "VM created successfully."

    # ---------------------------------------------------
    # Disable Secure Boot
    # ---------------------------------------------------

    Write-Host "Disabling Secure Boot..."

    Set-VMFirmware `
        -VMName $vmName `
        -EnableSecureBoot Off

    # ---------------------------------------------------
    # Configure CPU
    # ---------------------------------------------------

    Write-Host "Configuring CPU..."

    Set-VMProcessor `
        -VMName $vmName `
        -Count $cpu

    # ---------------------------------------------------
    # Attach Custom Oracle Linux ISO
    # ---------------------------------------------------

    Write-Host "Attaching custom Oracle Linux ISO..."

    Add-VMDvdDrive `
        -VMName $vmName `
        -Path $isoPath

    # ---------------------------------------------------
    # Configure Boot Order
    # ---------------------------------------------------

    Write-Host "Configuring boot order..."

    $dvd = Get-VMDvdDrive -VMName $vmName

    Set-VMFirmware `
        -VMName $vmName `
        -FirstBootDevice $dvd

    # ---------------------------------------------------
    # Add Private NIC
    # ---------------------------------------------------

    $pri = Get-VMSwitch -Name $privateSwitch -ErrorAction SilentlyContinue

    if ($pri) {

        Write-Host "Adding private NIC..."

        Add-VMNetworkAdapter `
            -VMName $vmName `
            -SwitchName $privateSwitch `
            -Name "PrivateNIC"

        Write-Host "Private NIC added successfully."
    }
    else {
        Write-Host "Private switch '$privateSwitch' not found. Skipping private NIC."
    }

    # ---------------------------------------------------
    # Start VM
    # ---------------------------------------------------

    Write-Host "Booting VM using custom kickstart ISO..."

    Start-VM -Name $vmName | Out-Null

    Write-Host "===================================="
    Write-Host "Silent installation initiated"
    Write-Host "VM Name : $vmName"
    Write-Host "===================================="
}
else {

    Write-Host "VM '$vmName' already exists."
}

# ---------------------------------------------------
# Display VM Status
# ---------------------------------------------------

Write-Host ""
Write-Host "Current VM Status:"
Get-VM -Name $vmName