Function OPEN_EXPLORER{explorer .}
Function CD_GIT{Set-Location C:\Work\Git\}
Function GIT_PULL{git pull}
Function GIT_RESET_TO_MAIN{git reset --hard origin/main}
Function GIT_LOG_ONE_LINE{git log --oneline}
Function FORCE_PUSH_WITH_LEASE{git push --force-with-lease}
Function SKIP_CI{git push -o ci.skip}
Function GIT_REFRESHED_FETCH{git fetch; git status}
Function REFRESH_ENV{$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")}

Set-Alias exp OPEN_EXPLORER
Set-Alias cdGit CD_GIT
Set-Alias gpll GIT_PULL
Set-Alias gmr GIT_RESET_TO_MASTER
Set-Alias glog GIT_LOG_ONE_LINE
Set-Alias gfpush FORCE_PUSH_WITH_LEASE
Set-Alias skipci SKIP_CI
Set-Alias gfet GIT_REFRESHED_FETCH
Set-Alias RefEnv REFRESH_ENV
