function Get-KeySignature {
    param (
        [CmdletBinding()]
        $KeyScale
    )
    return $KeyScale.notes | where {$_ -match "\wb|\w#"}
}