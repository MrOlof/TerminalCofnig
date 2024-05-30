#Prompt
#oh-my-posh init pwsh |  Invoke-Expression
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/MrOlof/terminal-configs/main/myprofile.omp.json' | Invoke-Expression
# Load other modules
Import-Module posh-git
Import-Module Terminal-Icons

# Set PSReadLine options
Set-PSReadLineOption -EditMode Emacs

# Additional custom settings
Set-Alias ll Get-ChildItem

function Greet-User {
    param (
        [string]$name = "User"
    )
    Write-Host "Hello, $name!"
}

Greet-User -name "Kosta"
