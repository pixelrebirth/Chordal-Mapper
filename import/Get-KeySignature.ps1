function Get-KeySignature {
    param (
        [CmdletBinding()]
        $key_scale
    )
    return $key_scale.notes | where {$_ -match "\wb|\w#"}
}