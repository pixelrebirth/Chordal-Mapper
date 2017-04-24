# # function Get-ChordalRelationship {
#     param (
#         [ValidateSet("A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D", "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb")]$root_key,
#         [ValidateSet("Major","Minor","Dim")]$scale_type
#     )

    $root_key = "F#"
    $scale_type = 'Dim'

    import-module .\Chordal-Mapper.psd1 -force

    $scale = Get-KeyScale -root_key $root_key -scale_type $scale_type
    $signature = Get-KeySignature -key_scale $scale
    Write-Output "
        Scale: $(($scale.notes) -join("-"))
        Signature: $(($signature) -join("-"))
    "

    $chordal_map = Convert-ChordalMap -scale $scale
    $chordal_map | Format-Table
# }