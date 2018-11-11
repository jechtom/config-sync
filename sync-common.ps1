$ErrorActionPreference = "Stop";

# constants
$localDataFolderName = "..\local"
$encryptedDataFolderName = "..\data-encrypted"

$encryptedDataPath = join-path $PSScriptRoot $encryptedDataFolderName
$localDataPath = join-path $PSScriptRoot $localDataFolderName

# functions

function Get-StringHashSHA256([Parameter(Mandatory=$true)][string]$str) {
    $inputBytes = [System.Text.Encoding]::UTF8.GetBytes($str)
    $hashAlg = new-object System.Security.Cryptography.SHA256Managed 
    $hash = $hashAlg.ComputeHash($inputBytes)
    $hashAlg.Dispose()
    return ($hash|ForEach-Object ToString X2) -join ''
}

function Get-FolderHash([string]$path) {

    # compute hash of folder
    # format:
    # - all encoding is using UTF8
    # - get all files in folder
    # - order files by full name
    # - build string from following parts; for each file:
    #   - add hash of relative file path (relative path in format "folder/myFile.txt")
    #   - add ";"
    #   - add SHA256 hash of file content; following with ";"
    #   - add ";"
    # - compute hash of this string

    $path = $path.trim('\').trim('/') # remove trailing slashes in path

    $hashStringBuilder = New-Object System.Text.StringBuilder 

    Get-ChildItem $path -Recurse -Force -File | Sort-Object -Property FullName | %{

        $fixedRelativePath = $_.FullName.Substring($path.Length).Replace("\", "/")
        $fileHash = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
        $pathHash = Get-StringHashSHA256 $fixedRelativePath

        $hashStringBuilder.Append($pathHash)
        $hashStringBuilder.Append(";")
        $hashStringBuilder.Append($fileHash)
        $hashStringBuilder.Append(";")

        return
    } | out-null

    $folderHash = Get-StringHashSHA256 $hashStringBuilder.ToString()
    return $folderHash
}

function Get-RandomPassword([int]$chars)
{
    # not sure if this is secure enough
    return [System.Web.Security.Membership]::GeneratePassword($chars,0)
}

# require 7zip
if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
Set-Alias sz "$env:ProgramFiles\7-Zip\7z.exe" 