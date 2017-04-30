function Convert-ChordalMap {
    param ($scale)

    $mode_names = @('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')
    foreach ($each_name in $mode_names){
        $chord_per_mode = [ChordMap]::new()
        $mode_scale = $chord_per_mode.GetScale()
        $current_mode = [Mode]::new($each_name)
        1..7 | foreach {

        }

    }
}
