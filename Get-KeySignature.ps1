function Get-KeySignature {
    param (
        [CmdletBinding()]
        $key_scale
    )
    return $key_scale | where {$_ -match "\wb|\w#"}
}