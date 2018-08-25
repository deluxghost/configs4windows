if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
    Import-Module Get-ChildItemColor
    Set-Alias ll Get-ChildItemColor -option AllScope
    Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
} else {
    Set-Alias ll Get-ChildItem -option AllScope
    Set-Alias ls Get-ChildItem -option AllScope
}

Remove-Item alias:cd
function cd {
    if ($args.length -eq 0) {
        Set-Location "$($env:homedrive)$($env:homepath)"
    } else {
        Set-Location ($args -join " ")
    }
}

function ping {
    if ($args.length -eq 0) {
        ping.exe
    } else {
        ping.exe -t ($args -join " ")
    }
}

function prompt {
    $Host.UI.RawUI.WindowTitle = "PowerShell" + " (" + $pwd.Provider.Name + ") " + $pwd.Path

    if ((New-Object Security.Principal.WindowsPrincipal (
            [Security.Principal.WindowsIdentity]::GetCurrent())
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
        $Host.UI.RawUI.WindowTitle = "[Admin] " + $Host.UI.RawUI.WindowTitle
        Write-Host "#Admin" -nonewline -foregroundcolor Red
    } else {
        Write-Host $env:username -nonewline -foregroundcolor Green
    }

    Write-Host "@" -nonewline -foregroundcolor Cyan
    Write-Host $env:COMPUTERNAME -nonewline -foregroundcolor Green

    if ($pwd.Provider.Name -ne "FileSystem") {
        Write-Host  " #$($pwd.Provider.Name)" -nonewline -foregroundcolor DarkCyan
    }
    
    Write-Host  " " -nonewline

    if ($pwd.Path -eq "$($env:homedrive)$($env:homepath)") {
        Write-Host ~ -foregroundcolor Yellow
    } else {
        Write-Host $pwd.Path -foregroundcolor Yellow
    }

    Write-Host ">>" -nonewline -foregroundcolor Red

    return " `b"
}
