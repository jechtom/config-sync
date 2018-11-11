$ErrorActionPreference = "Stop";

. (join-path $PSScriptRoot ".\sync-common.ps1")

# get last revision
Write-Host "Fetching changes"
pushd $encryptedDataPath
try
{
    pushd $encryptedDataPath
    $revision = (git rev-parse HEAD)
    git pull
    $revision2 = (git rev-parse HEAD)
    if($revision -eq $revision2) {
        write-host "No changes. Latest commit is $revision2"
        return
    }
}
finally
{
    popd
}

# read all folders
$archives = Get-ChildItem -File $encryptedDataPath -Filter "*.7z"

# restore
$needToCommit = $false
$archives | %{ 

    # get info
    $repoArchiveFile = $_.FullName
    $itemName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $localForItemPath = join-path $localDataPath $itemName
    Write-Host "Checking $itemName"

    # get encryption key
    $encryptionKeyFile = (Join-Path $localDataPath ($itemName + ".key"))
    if(-not (test-path $encryptionKeyFile)) {
        write-host "Ignoring $itemName - no key file $encryptionKeyFile"
        return
    }
    $encryptionKey = (get-content $encryptionKeyFile)

    Write-Host "Extracting to $localForItemPath"
    if(test-path $localForItemPath) { rmdir -Force -Recurse $localForItemPath }
    mkdir $localForItemPath
    sz x "$repoArchiveFile" $("-o" + $localForItemPath) * $("-p" + $encryptionKey)

} | out-null


return