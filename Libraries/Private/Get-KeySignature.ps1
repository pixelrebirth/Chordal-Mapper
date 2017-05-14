function Get-KeySignature {
    param (
        [CmdletBinding()]
        $KeyScale
    )
    return $KeyScale.notes | where {$Input -match "\wb|\w#"}
}