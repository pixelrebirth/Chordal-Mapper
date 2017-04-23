function Get-ChordalRelationship {
    param (
        [ValidateSet("A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D", "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb")]$root_key,
        [ValidateSet("Major","Minor","Dim")]$scale_type
    )

    $scale = Get-KeyScale -root_key $key -scale_type $scale_type
    Write-Output $(($scale | sort) -join("-"))

    $signature = Get-KeySignature -key_scale $scale
    Write-Output $signature

    $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    if ($scale_type -eq "Major"){$base_chord = $chordal_data | Where {$_.mode -eq "Ionian"}}
    if ($scale_type -eq "Minor"){$base_chord = $chordal_data | Where {$_.mode -eq "Aeolian"}}
    if ($scale_type -eq "Dim"){$base_chord = $chordal_data | Where {$_.mode -eq "Locrian"}}

    Convert-ChordalMap -chord $base_chord -scale $scale

}