# Define variables
$repoUrl = "https://github.com/MrOlof/terminal-configs.git"
$repoPath = "$HOME\terminal-configs"
$nvimConfigPath = "$HOME\AppData\Local\nvim"
$powershellConfigPath = "$HOME\Documents\PowerShell"
$terminalSettingsPath = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$fontInstallPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
$fontSourcePath = "$repoPath\CascadiaCode"

# Clone the repository
if (-not (Test-Path -Path $repoPath)) {
    git clone $repoUrl $repoPath
}

# Copy Neovim configuration
New-Item -ItemType Directory -Force -Path $nvimConfigPath
Copy-Item -Force "$repoPath\nvim\init.vim" -Destination "$nvimConfigPath\init.vim"

# Copy PowerShell profile and custom oh-my-posh JSON
New-Item -ItemType Directory -Force -Path $powershellConfigPath
Copy-Item -Force "$repoPath\powershell\Microsoft.PowerShell_profile.ps1" -Destination "$powershellConfigPath\Microsoft.PowerShell_profile.ps1"
Copy-Item -Force "$repoPath\powershell\myprofile.omp.json" -Destination "$powershellConfigPath\myprofile.omp.json"

# Install Neovim (example for Windows - assuming Chocolatey is installed)
choco install neovim -y

# Install PowerShell modules
Install-Module -Name oh-my-posh -Scope CurrentUser -Force
Install-Module -Name posh-git -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
Install-Module -Name z -Scope CurrentUser -Force

# Install Node.js and Yarn
choco install nodejs -y
choco install nvm -y
nvm install latest
nvm use latest
npm install --global yarn

# Install CascadiaCode Nerd Font from repository
$fontFiles = Get-ChildItem -Path $fontSourcePath -Filter "*.ttf"
foreach ($fontFile in $fontFiles) {
    Copy-Item -Force "$fontFile.FullName" -Destination "$fontInstallPath\$($fontFile.Name)"
}

# Add the fonts to the registry
foreach ($fontFile in $fontFiles) {
    $fontName = $fontFile.Name.Replace(".ttf", "")
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Name "$fontName (TrueType)" -Value "$fontInstallPath\$($fontFile.Name)" -Force
}

# Copy Windows Terminal settings
Copy-Item -Force "$repoPath\terminal-settings.json" -Destination "$terminalSettingsPath\settings.json"

# Install Git for Windows
choco install git -y

# Generate SSH key (if not exists)
if (-not (Test-Path -Path "$HOME\.ssh\id_rsa.pub")) {
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "$HOME\.ssh\id_rsa" -N ""
}

# Install Vim-Plug for Neovim
Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile "$HOME\AppData\Local\nvim\autoload\plug.vim"

# Install Neovim plugins
nvim +PlugInstall +qall

# Install COC extensions for Neovim
nvim +'CocInstall coc-tsserver coc-json coc-html coc-css coc-pyright' +qall
