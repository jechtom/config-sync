# CONFIG SYNC TOOLS

This is set of my scripts I use to sync my config files over devices using private repo.

## Sync Process

1. Latest version of encrypted config folders are downloaded using GIT from your private repository

2. Folders are decrypted (if you have access key for it)

3. Your config will be merged with decrypted config files

4. Changed config folders are encrypted and pushed to your private repository

## How-Tos

* [How to Set-Up Sync for Keepass](docs/keepass.md)

## Installation

1. Create and close GIT private repository where encrypted config files will be stored.

2. Open command line in folder where would you like to init settings repository and run folowing command:

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jechtom/config-sync-tools/master/create-new-repo.ps1?v=' + [System.Environment]::TickCount.ToString()))"
```

This command downloads and executes [this script](create-new-repo.ps1). If you want, you can download and inspect and run it manually.

3. Execute command `config-sync-tools\create-new-item.cmd` to crete new config folders with random passwords for each of it.

4. Clone your private repository to your other devices.

5. Copy `.key` files from `local` folder (which is ignored from GIT) to your other devices to give access to specific config folders.

6. Follow how-tos articles to set-up synchronization.
