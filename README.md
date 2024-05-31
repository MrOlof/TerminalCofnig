# Terminal Config

![Powershell3](https://github.com/MrOlof/terminal-configs/assets/100124559/c25c480a-97e8-4b9d-a978-cfd4af09c726)


## SETUP

Install Powershell via Microsoft Store
import terminal-settings.json to $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState

```winget install Neovim.Neovim```

Copy init.vim and main.py to 
$HOME\AppData\Local\nvim

Copy terminal json
$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState

```winget install Neovim.Neovim```

install Vim-Plug:
```iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "$HOME\AppData\Local\nvim\autoload\plug.vim" -Force ```

``` winget install --id Git.Git -e --source winget ```

cd $HOME\AppData\Local\nvim
nvim init.vim
:pluginstall

Optional:
Create SSH Key
dd $HOME\.ssh (or mkdir if path does not exist)
ssh-keygen 
Upload keys to developers settings in github

nvim
# Inside Neovim, type the following command and press Enter:
:PlugInstall

cd $HOME\AppData\Local\nvim-data\plugged\
``` winget install -e --id OpenJS.NodeJS```
# Verify installation - restart terminal first
```node -v``` 

Install chocolatey:
powershell admin and run:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Run as admin
```choco install nvm -y```
cd $HOME\AppData\Local\nvim-data\plugged\coc.nvim
```npm install --global yarn```
````yarn --version````
````yarn install````
yarn build

cd $HOME\AppData\Local\nvim\ 
nvim init.vim

````winget install JanDeDobbeleer.OhMyPosh -s winget````
restart

Echo $PROFILE (to check path for profile)

