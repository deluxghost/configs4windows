clear

New-Alias "cd~" "cd ~"

function prompt
{
    $Host.UI.RawUI.WindowTitle = "PowerShell" + " (" + $pwd.Provider.Name + ") " + $pwd.Path
    Write-Host "[" -nonewline -foregroundcolor DarkGray

    if( (
        New-Object Security.Principal.WindowsPrincipal (
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
        Write-Host  " $($pwd.Provider.Name)" -nonewline -foregroundcolor DarkCyan
    }

    Write-Host "] " -nonewline -foregroundcolor DarkGray

    if ($pwd.Path -eq "$($env:homedrive)$($env:homepath)") {
        Write-Host ~~ -nonewline -foregroundcolor Yellow
    } else {
        $pwd.Path.Split("\") | foreach {
            Write-Host $_ -nonewline -foregroundcolor Yellow
            Write-Host "\" -nonewline -foregroundcolor Gray
        }
    }

    Write-Host "`b `n" -nonewline -foregroundcolor Gray
    Write-Host ">>" -nonewline -foregroundcolor Red

    return " "
}