# Clone the repository
git clone https://github.com/MrOlof/terminal-configs.git

# Copy Neovim configuration
New-Item -ItemType Directory -Force -Path $HOME\AppData\Local\nvim
Copy-Item -Force $HOME\terminal-configs\nvim\init.vim -Destination $HOME\AppData\Local\nvim\init.vim

# Copy PowerShell profile
New-Item -ItemType Directory -Force -Path $HOME\Documents\PowerShell
Copy-Item -Force $HOME\terminal-configs\powershell\Microsoft.PowerShell_profile.ps1 -Destination $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# Install Neovim (example for Windows - assuming Chocolatey is installed)
choco install neovim -y

# Install PowerShell modules
Install-Module -Name oh-my-posh -Scope CurrentUser -Force
Install-Module -Name posh-git -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
Install-Module -Name Z -Scope CurrentUser -Force
