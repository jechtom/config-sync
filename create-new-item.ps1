param (
    [Parameter(Mandatory=$true)][string]$itemName    
)

$ErrorActionPreference = "Stop";

. (join-path $PSScriptRoot ".\sync-common.ps1")

$path = join-path $localDataPath $itemName
$pathKey = join-path $localDataPath ($itemName + ".key")
$key = Get-RandomPassword(30)

if(Test-path $path) {
    throw "Item $itemName already exists in $path"
}

if(Test-path $pathKey) {
    throw "Key file already exists in $pathKey"
}

# create folder and add key
mkdir $path
$key > $pathKey

write-host 
write-host "Created new item $itemName and new secret key."
write-host "New path: $path"