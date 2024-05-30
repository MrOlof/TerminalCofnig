# Define variables
$repoUrl = "https://github.com/MrOlof/terminal-configs.git"
$repoPath = "$HOME\terminal-configs"
$nvimConfigPath = "$HOME\AppData\Local\nvim"
$powershellConfigPath = "$HOME\Documents\PowerShell"
$terminalSettingsPath = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$fontInstallPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
$fontSourcePath = "$repoPath\CascadiaCode"

# Ensure Chocolatey is installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 0x300
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) *>$null
}

# Install Git using Chocolatey
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    choco install git -y *>$null
}

# Install NVM using Chocolatey
if (-not (Get-Command nvm -ErrorAction SilentlyContinue)) {
    choco install nvm -y *>$null
    $env:Path += ";C:\ProgramData\nvm"
}

# Install Node.js and Yarn
nvm install latest
nvm use latest
$env:Path += ";C:\Users\$env:USERNAME\AppData\Roaming\nvm;$($env:LOCALAPPDATA)\Microsoft\WindowsApps;$($env:APPDATA)\npm"
npm install --global yarn *>$null

# Clone the repository
if (-not (Test-Path -Path $repoPath)) {
    git clone $repoUrl $repoPath *>$null
}

# Copy Neovim configuration
New-Item -ItemType Directory -Force -Path $nvimConfigPath *>$null
Copy-Item -Force "$repoPath\nvim\init.vim" -Destination "$nvimConfigPath\init.vim" *>$null

# Copy PowerShell profile and custom oh-my-posh JSON
New-Item -ItemType Directory -Force -Path $powershellConfigPath *>$null
Copy-Item -Force "$repoPath\powershell\Microsoft.PowerShell_profile.ps1" -Destination "$powershellConfigPath\Microsoft.PowerShell_profile.ps1" *>$null
Copy-Item -Force "$repoPath\powershell\myprofile.omp.json" -Destination "$powershellConfigPath\myprofile.omp.json" *>$null

# Install Neovim using Chocolatey
choco install neovim -y *>$null

# Install PowerShell modules
Install-Module -Name oh-my-posh -Scope CurrentUser -Force *>$null
Install-Module -Name posh-git -Scope CurrentUser -Force *>$null
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force *>$null
Install-Module -Name z -Scope CurrentUser -Force *>$null

# Install CascadiaCode Nerd Font from repository
$fontFiles = Get-ChildItem -Path $fontSourcePath -Filter "*.ttf"
foreach ($fontFile in $fontFiles) {
    Copy-Item -Force "$fontFile.FullName" -Destination "$fontInstallPath\$($fontFile.Name)" *>$null
}

# Add the fonts to the registry
foreach ($fontFile in $fontFiles) {
    $fontName = $fontFile.Name.Replace(".ttf", "")
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Name "$fontName (TrueType)" -Value "$fontInstallPath\$($fontFile.Name)" -Force *>$null
}

# Copy Windows Terminal settings
Copy-Item -Force "$repoPath\terminal-settings.json" -Destination "$terminalSettingsPath\settings.json" *>$null

# Generate SSH key (if not exists)
if (-not (Test-Path -Path "$HOME\.ssh\id_rsa.pub")) {
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "$HOME\.ssh\id_rsa" -N "" *>$null
}

# Install Vim-Plug for Neovim
New-Item -ItemType Directory -Force -Path "$HOME\AppData\Local\nvim\autoload" *>$null
Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile "$HOME\AppData\Local\nvim\autoload\plug.vim" *>$null

# Install Neovim plugins
nvim +PlugInstall +qall *>$null

# Install COC extensions for Neovim
nvim +'CocInstall coc-tsserver coc-json coc-html coc-css coc-pyright' +qall *>$null
