# Terminal Config

![Powershell2](https://github.com/MrOlof/terminal-configs/assets/100124559/e6a2fb29-0b07-4f24-8707-f16576470e53)



## SETUP

Copy terminal json
$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState

```winget install Neovim.Neovim```

Copy init.vim to 
$HOME\Documents\terminal-configs\nvim\init.vim" -Destination "$nvimConfigPath\init.vim

install Vim-Plug:
```iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "$HOME\AppData\Local\nvim\autoload\plug.vim" -Force ```

nvim
# Inside Neovim, type the following command and press Enter:
:PlugInstall

```winget install --id Git.Git -e --source winget```

Create SSH Key
d $HOME\.ssh
ssh-keygen 

nvim
# Inside Neovim, type the following command and press Enter:
:PlugInstall

```winget install -e --id OpenJS.Node.JS```
# Verify installation
```node -v``` 

```choco install nvm -y```

cd $HOME\AppData\Local\nvim-data\plugged\coc.nvim
npm install --global yarn

````yarn install````

nvim
# Inside Neovim, type the following command and press Enter:
:CocInstall coc-python

Copy-Item -Force "$HOME\Documents\terminal-configs\nvim\main.py" -Destination "$HOME\AppData\Local\nvim\main.py"

winget install JanDeDobbeleer.OhMyPosh -s winget


# Create or edit your PowerShell profile
echo $PROFILE
# Make sure the directories exist
mkdir -Force (Split-Path -Parent $PROFILE)
# Open the profile in Neovim
nvim $PROFILE

cd $HOME\Documents
mkdir -Force PowerShell
Copy-Item -Force "$HOME\Documents\terminal-configs\powershell\Microsoft.PowerShell_profile.ps1" -Destination "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Copy-Item -Force "$HOME\Documents\terminal-configs\powershell\myprofile.omp.json" -Destination "$HOME\Documents\PowerShell\myprofile.omp.json"


Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
Install-Module -Name z -Scope CurrentUser -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force


