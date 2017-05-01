function Convert-ChordalMap {
    param ($song_scale)

    $mode_names = @('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')
    $allChords = @()
    $index_count = 0

    foreach ($each_name in $mode_names){
        $index_count++
        $notes = @()
        $current_mode = [Mode]::new($each_name)
        $mode_scale = $current_mode.GetScale($song_scale)
        $chord_per_mode = [ChordMap]::new()
        1..5 | foreach {$notes += $mode_scale.notes}
        
        1..7 | foreach {
            $num = $_
            $base_note = $num - 1
            $chord_per_mode."chord_$num" = $($notes[$base_note]) + "-" + $($notes[($base_note+2)]) + "-" + $($notes[($base_note+4)]) + "-" + $($notes[($base_note+6)]) + "-" + $($current_mode.voice[$base_note])
            $chord_per_mode.index = [string]$index_count
        }
        $chord_per_mode.type = $current_mode.type
        $chord_per_mode.mood = $current_mode.mood
        $chord_per_mode.mode = $current_mode.name
        $allChords += $chord_per_mode
    }
    return $allChords
}
