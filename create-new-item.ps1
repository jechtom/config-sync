$ErrorActionPreference = "Stop";

. (join-path $PSScriptRoot ".\sync-common.ps1")

param (
    [Parameter(Mandatory=$true)][string]$itemName    
)

$path = Path-Join $localDataPath $itemName
$pathKey = Path-Join $localDataPath ($itemName + ".key")
$key = Get-RandomPassword(30)

if(Test-path $path) {
    throw "Item $itemName already exists in $path"
}

mkdir $localDataPath
$key > $pathKey

write-host "Created new item $itemName and new secret key."