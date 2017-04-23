function Get-ChordalRelationship {
    param (
        $key = "C",
        $scale_type = "Major"
    )

    $scale = Get-KeyScale -root_key $key -scale_type $scale_type
    Write-Output $(($scale | sort) -join("-"))

    $signature = Get-KeySignature -key_scale $scale

    $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    $base_chord = $chordal_data | Where {$_.mode -eq "Ionian"}

    $output = @()
    # $output += Convert-ChordalMap -chord $base_chord -diff 0
    return $output | Format-Table
}