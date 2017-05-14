$ModulePath = $PSScriptRoot
$AllFiles = Get-ChildItem -Path "$ModulePath/Libraries/*.ps1" -Recurse
$AllFiles | ForEach {. $_}
