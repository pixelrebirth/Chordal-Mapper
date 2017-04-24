function Convert-ChordalMap {
    param ($scale)

    $scale_offset = $scale.offset
    $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    if ($scale.type -eq "Major"){$chord = $chordal_data | Where {$_.mode -eq "Ionian"}}
    if ($scale.type -eq "Minor"){$chord = $chordal_data | Where {$_.mode -eq "Aeolian"}}
    if ($scale.type -eq "Dim"){$chord = $chordal_data | Where {$_.mode -eq "Locrian"}}

    if ($scale.notes  -match "\wb"){
        $notes_array = 0..100 | foreach {@('A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab')}
    }
    
    if ($scale.notes  -match "\w#"){
        $notes_array = 0..100 | foreach {@('A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#')}
    }
    
    $count = 0
    $notes_array | foreach {
        if ($_ -eq $scale.notes[0]){$diff = $count}
        else {$count++}
    }

    $chord_base = [int]$chord.Chord_1.split('-')[0] + $diff - 2
    1..7 | foreach-object {
        $chord_num = $_
        $array = $chord."chord_$chord_num".split('-')

        $array += ':'

        if ($array[0] -eq 23){
            $firstDiff = $array[1] - -1 #calibrated to map
        }
        else {
            $firstDiff = $array[1] - $array[0]
        }
        $secondDiff = $array[2] - $array[1]

        0..4 | foreach-object {
                if ($_ -eq 4){
                    if ($firstDiff -gt $secondDiff){$array[$_] = "^"}
                    if ($firstDiff -lt $secondDiff){$array[$_] = "."}
                    if ($firstDiff -eq $secondDiff){$array[$_] = "!"}
                }
                else {
                    $note_step = [int]$chord_base + [int]$array[$_]
                    $note_step
                    $array[$_] = $notes_array[$note_step]
                }
        }
        $string = $array -join "-"
        $chord."chord_$chord_num" = $string
    }
    return $chord
}
