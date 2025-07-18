<#
.SYNOPSIS
    Install and configure WSL2 with a specified Linux distro and user for SulacoLAN nodes.

.DESCRIPTION
    - Installs WSL2 and required Windows features
    - Installs Debian (or another specified distro)
    - Creates a new Linux user with a consistent name across nodes
    - Sets WSL2 as default backend
    - Optionally applies custom dotfiles

.NOTES
    Requires Windows 10 2004+ or Windows 11, and admin privileges
#>

param (
    [string]$Distro = "Debian",
    [string]$LinuxUser = "mcweathers"
)

Write-Host ">> Installing WSL and enabling required Windows features..." -ForegroundColor Cyan

# Install WSL and enable features
wsl --install -d $Distro
wsl --set-default-version 2

# Wait for installation to complete (user may need to create the user interactively)
Write-Host "`n>> Please follow the on-screen steps to complete the initial Linux setup." -ForegroundColor Yellow
Write-Host "   When done, press ENTER to continue." -ForegroundColor Yellow
Pause

# Set user as default login
Write-Host "`n>> Setting default user for $Distro to '$LinuxUser'..." -ForegroundColor Cyan
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss"
$lxssKeys = Get-ChildItem $regPath | Where-Object {
    (Get-ItemProperty $_.PSPath).DistributionName -eq $Distro
}

if ($lxssKeys.Count -eq 0) {
    Write-Host "!! Unable to find distro registry key. Please ensure WSL installed correctly." -ForegroundColor Red
    exit 1
}

foreach ($key in $lxssKeys) {
    Set-ItemProperty -Path $key.PSPath -Name DefaultUid -Value 1000
}

# Optional: setup common dotfiles via bash command
Write-Host "`n>> Copying default .bashrc or config files (optional)..." -ForegroundColor Cyan
wsl -d $Distro -u $LinuxUser -- bash -c "echo '# SulacoLAN default config' >> ~/.bashrc"

Write-Host "`n✅ WSL2 install and basic user config complete." -ForegroundColor Green
Write-Host "   You can now run: wsl -d $Distro -u $LinuxUser" -ForegroundColor Green

