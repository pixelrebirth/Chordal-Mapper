function Convert-ChordalMap {
    param ($song_scale)

    $mode_names = @('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')
    $allChords = @()

    foreach ($each_name in $mode_names){
        $current_mode = [Mode]::new($each_name)
        $mode_scale = $current_mode.GetScale($song_scale)
        1..7 | foreach {
            $chord_per_mode = [ChordMap]::new()
            $base_note = $_ - 1
            $chord_per_mode."chord_$_" = "$($mode_scale[$base_note])-$($mode_scale[$base_note+2])-$($mode_scale[$base_note+4])-$($mode_scale[$base_note+6])-$($mode_scale[$base_note]-$($current_mode.voice[$base_note]))"
        }
        $allChords += $chord_per_mode
    }
    return $allChords
}
