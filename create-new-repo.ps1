$ErrorActionPreference = "Stop";
$path = $PSScriptRoot
Write-Host "Creating config sync repo in $pwd"

pushd $pwd
try
{
    # create repo if not exists yet
    if(-not (test-path .git)) { git init }

    # gitignore file
    "/local/*`r`n!/local/.gitkeep" > .gitignore
    
    # basic folder structure
    mkdir .\local
    mkdir .\data-encrypted
    new-item .\local\.gitkeep -itemtype file
    new-item .\data-encrypted\.gitkeep -itemtype file

    # get tools in nested dir
    git clone https://github.com/jechtom/config-sync-tools.git
}
finally
{
    popd
}

Write-Host "Done."