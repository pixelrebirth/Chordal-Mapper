$module_path = $PSScriptRoot
$all_ps1 = Get-ChildItem *.ps1 -recurse
$all_ps1 | ForEach-Object {. $_}