# Install-Module -Name Terminal-Icons -Repository PSGallery
Import-Module -Name Terminal-Icons
# scoop install posh-git
Import-Module $home\scoop\modules\posh-git
oh-my-posh init pwsh --config 'C:/Users/tomyh/AppData/Local/Programs/oh-my-posh/themes/gmay.omp.json' | Invoke-Expression

Function OPEN_EXPLORER{explorer .}
Function CD_CPAP_DIR{Set-Location C:\Work\Git\SleepstyleRepos\sleepstyle\}
Function CD_AATS_DIR{Set-Location C:\Work\Git\SleepstyleRepos\AATS\}
Function CD_FEATURES_RELEASE{Set-Location C:\Work\Git\SleepstyleRepos\sleepstyle\CpapApplication\AATS\TestSuite\Features\bin\Release}
Function CD_GIT{Set-Location C:\Work\Git\}
Function GIT_PULL{git pull}
Function GIT_RESET_TO_MAIN{git reset --hard origin/main}
Function GIT_LOG_ONE_LINE{git log --oneline --decorate --graph}
Function FORCE_PUSH_WITH_LEASE{git push --force-with-lease}
Function SKIP_CI{git push -o ci.skip}
Function GIT_REFRESHED_FETCH{git fetch; git status}
Function REFRESH_ENV{$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")}
Function ACTIVATE_ZEPHYR_VENV{Invoke-Expression $Home\zephyrproject\.Zephyr-Proto\Scripts\Activate.ps1}
function ACTIVATE_MKDOCS_VENV { Set-Location C:\Users\tomyh\; .mkdocsvenv\Scripts\Activate.ps1; Set-Location -}
function LIST_USBIPD { usbipd wsl list }

Set-Alias exp OPEN_EXPLORER
Set-Alias cdCpap CD_CPAP_DIR
Set-Alias cdAats CD_AATS_DIR
Set-Alias cdFeatures CD_FEATURES_RELEASE
Set-Alias cdGit CD_GIT
Set-Alias gpll GIT_PULL
Set-Alias gmr GIT_RESET_TO_MAIN
Set-Alias glog GIT_LOG_ONE_LINE
Set-Alias gfpush FORCE_PUSH_WITH_LEASE
Set-Alias skipci SKIP_CI
Set-Alias gfet GIT_REFRESHED_FETCH
Set-Alias RefEnv REFRESH_ENV
Set-Alias ActZep ACTIVATE_ZEPHYR_VENV
Set-Alias ActMk ACTIVATE_MKDOCS_VENV
Set-Alias uwl LIST_USBIPD
