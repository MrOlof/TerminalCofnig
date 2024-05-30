# Clone the repository
git clone https://github.com/yourusername/terminal-configs.git $HOME\terminal-configs

# Copy Neovim configuration
New-Item -ItemType Directory -Force -Path $HOME\AppData\Local\nvim
Copy-Item -Force $HOME\terminal-configs\nvim\init.vim -Destination $HOME\AppData\Local\nvim\init.vim

# Copy PowerShell profile and custom oh-my-posh JSON
New-Item -ItemType Directory -Force -Path $HOME\Documents\PowerShell
Copy-Item -Force $HOME\terminal-configs\powershell\Microsoft.PowerShell_profile.ps1 -Destination $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
Copy-Item -Force $HOME\terminal-configs\powershell\myprofile.omp.json -Destination $HOME\Documents\PowerShell\myprofile.omp.json

# Install Neovim (example for Windows - assuming Chocolatey is installed)
choco install neovim -y

# Install PowerShell modules
Install-Module -Name oh-my-posh -Scope CurrentUser -Force
Install-Module -Name posh-git -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force

# Install CascadiaMono Nerd Font
$nerdFontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaMono.zip"
$tempPath = "$env:TEMP\CascadiaMono.zip"
$installPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

# Download the font
Invoke-WebRequest -Uri $nerdFontUrl -OutFile $tempPath

# Unzip the font
Expand-Archive -Path $tempPath -DestinationPath $installPath

# Add the font to the registry
$fontFiles = Get-ChildItem -Path $installPath -Filter "*.ttf"
foreach ($fontFile in $fontFiles) {
    $fontName = $fontFile.Name.Replace(".ttf", "")
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Name "$fontName (TrueType)" -Value $fontFile.FullName -Force
}

# Copy Windows Terminal settings
cp $HOME\terminal-configs\terminal-settings.json $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
