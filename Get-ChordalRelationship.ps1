# # function Get-ChordalRelationship {
#     param (
#         [ValidateSet("A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D", "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb")]$root_key,
#         [ValidateSet("Major","Minor","Dim")]$scale_type
#     )

    $root_key = "Gb"
    $scale_type = 'Major'

    import-module .\Chordal-Mapper.psd1 -force

    $scale = Get-KeyScale -root_key $root_key -scale_type $scale_type
    $signature = Get-KeySignature -key_scale $scale
    Write-Output "
        Scale: $(($scale.notes) -join("-"))
        Signature: $(($signature) -join("-"))
    "

    try {
        $chordal_map = Convert-ChordalMap -scale $scale
    }
    catch {$error.exception.message ; exit 1}
    $chordal_map | Format-Table
# }