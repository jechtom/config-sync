# CONFIG SYNC TOOLS

This is my set of scripts I use to sync my settings over devices using private repo.

## How it works?

TBD

## Installation

1. Create and close GIT private repository where encrypted config files will be stored.

2. Open command line in folder where would you like to init settings repository and run folowing command:

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jechtom/config-sync-tools/master/create-new-repo.ps1?v=' + [System.Environment]::TickCount.ToString()))"
```

This command downloads and executes [this script](create-new-repo.ps1). If you want, you can download and inspect and run it manually.

3. Execute command `config-sync-tools\create-new-item.cmd` to crete new config item folder with random password.