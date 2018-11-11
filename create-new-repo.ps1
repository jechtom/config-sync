$ErrorActionPreference = "Stop";
$path = $PSScriptRoot
Write-Host "Creating config sync repo in $path"

pushd $path
try
{
    #git init
    #"/local.ignore/*`r`n!/local.ignore/.gitkeep" >> .gitignore
}
finally
{
    popd
}