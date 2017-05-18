$ModulePath = $PSScriptRoot
$AllFiles = Get-ChildItem -Path "$ModulePath/Libraries/*.ps1" -Recurse -Exclude *.tests.*,RunPester.ps1
$AllFiles | ForEach {. $Input}
