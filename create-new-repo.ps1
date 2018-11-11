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
    git submodule add https://github.com/jechtom/config-sync-tools.git config-sync-tools

    # commit
    git add -A
    git commit -m "Added config sync tools ( via script)"
}
finally
{
    popd
}

Write-Host "Done."
