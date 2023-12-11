# Credit to https://gist.github.com/shanselman/25f5550ad186189e0e68916c6d7f44c3?WT.mc_id=-blog-scottha

using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# Install-Module -Name z
Import-Module -Name z
# Install-Module -Name Terminal-Icons -Repository PSGallery
Import-Module -Name Terminal-Icons
# scoop install posh-git
Import-Module $home\scoop\modules\posh-git
oh-my-posh init pwsh --config 'C:/Users/tomyh/AppData/Local/Programs/oh-my-posh/themes/gmay.omp.json' | Invoke-Expression

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# This key handler shows the entire or filtered history using Out-GridView. The
# typed text is used as the substring pattern for filtering. A selected command
# is inserted to the command line without invoking. Multiple command selection
# is supported, e.g. selected by Ctrl + Click.
Set-PSReadLineKeyHandler -Key F7 `
                         -BriefDescription History `
                         -LongDescription 'Show command history' `
                         -ScriptBlock {
    $pattern = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
    if ($pattern)
    {
        $pattern = [regex]::Escape($pattern)
    }

    $history = [System.Collections.ArrayList]@(
        $last = ''
        $lines = ''
        foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath))
        {
            if ($line.EndsWith('`'))
            {
                $line = $line.Substring(0, $line.Length - 1)
                $lines = if ($lines)
                {
                    "$lines`n$line"
                }
                else
                {
                    $line
                }
                continue
            }

            if ($lines)
            {
                $line = "$lines`n$line"
                $lines = ''
            }

            if (($line -cne $last) -and (!$pattern -or ($line -match $pattern)))
            {
                $last = $line
                $line
            }
        }
    )
    $history.Reverse()

    $command = $history | Out-GridView -Title History -PassThru
    if ($command)
    {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
    }
}

# This example will replace any aliases on the command line with the resolved commands.
Set-PSReadLineKeyHandler -Key "Alt+%" `
                         -BriefDescription ExpandAliases `
                         -LongDescription "Replace all aliases with the full command" `
                         -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $startAdjustment = 0
    foreach ($token in $tokens)
    {
        if ($token.TokenFlags -band [TokenFlags]::CommandName)
        {
            $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
            if ($alias -ne $null)
            {
                $resolvedCommand = $alias.ResolvedCommandName
                if ($resolvedCommand -ne $null)
                {
                    $extent = $token.Extent
                    $length = $extent.EndOffset - $extent.StartOffset
                    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
                        $extent.StartOffset + $startAdjustment,
                        $length,
                        $resolvedCommand)

                    # Our copy of the tokens won't have been updated, so we need to
                    # adjust by the difference in length
                    $startAdjustment += ($resolvedCommand.Length - $length)
                }
            }
        }
    }
}

#
# Ctrl+Shift+j then type a key to mark the current directory.
# Ctrj+j then the same key will change back to that directory without
# needing to type cd and won't change the command line.

#
$global:PSReadLineMarks = @{}

Set-PSReadLineKeyHandler -Key Ctrl+J `
                         -BriefDescription MarkDirectory `
                         -LongDescription "Mark the current directory" `
                         -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey($true)
    $global:PSReadLineMarks[$key.KeyChar] = $pwd
}

Set-PSReadLineKeyHandler -Key Ctrl+j `
                         -BriefDescription JumpDirectory `
                         -LongDescription "Goto the marked directory" `
                         -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey()
    $dir = $global:PSReadLineMarks[$key.KeyChar]
    if ($dir)
    {
        cd $dir
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }
}

Set-PSReadLineKeyHandler -Key Alt+j `
                         -BriefDescription ShowDirectoryMarks `
                         -LongDescription "Show the currently marked directories" `
                         -ScriptBlock {
    param($key, $arg)

    $global:PSReadLineMarks.GetEnumerator() | % {
        [PSCustomObject]@{Key = $_.Key; Dir = $_.Value} } |
        Format-Table -AutoSize | Out-Host

    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

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
