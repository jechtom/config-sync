$ErrorActionPreference = "Stop";

. (join-path $PSScriptRoot ".\sync-common.ps1")

# read all folders
write-host "Getting items from $localDataPath"
$directories = Get-ChildItem -Directory $localDataPath

# calculate hashes
$needToCommit = $false
$directories | %{ 

    $path = $_.FullName
    $name = $_.Name

    # get encryption key
    $encryptionKeyFile = (Join-Path $localDataPath ($name + ".key"))
    if(-not (test-path $encryptionKeyFile)) {
        throw "Missing key file $encryptionKeyFile"
    }
    $encryptionKey = (get-content $encryptionKeyFile)

    # calculate hash
    $newHash = Get-FolderHash($path)
    Write-Host "Hash of folder $path is $newHash"

    $repoHashFile = Join-Path $encryptedDataPath "$name.hash"
    $repoArchiveFile = Join-Path $encryptedDataPath "$name.7z"

    $update = $false
    if ((-not (test-path $repoHashFile)) -or (-not (test-path $repoArchiveFile)))
    {
        Write-Host "New package $name"
        $update = $true
    }
    elseif ((get-content $repoHashFile) -ne $newHash)
    {
        $update = $true
    }

    if($update) {
        $needToCommit = $true
        Write-Host "Updating package $name"
        $newHash > $repoHashFile
        sz a $("-p" + $encryptionKey) -mhe=on -r "$repoArchiveFile" "$path\*.*"
    }
    else
    {
        Write-Host "No need to update $name"
    }
} | out-null

# commit if needed
if($needToCommit)
{
    Write-Host "Commit needed"
    pushd $encryptedDataPath
    try
    {
        git add -A
        git commit -m "Change from $($env:computername) at $((Get-Date).ToString("u"))"
        git push
    }
    finally
    {
        popd
    }
}

return