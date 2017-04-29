function Convert-ChordalMap {
    param ($scale)

    $scale_offset = $scale.offset
    # $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    if ($scale.type -eq "Major"){$root_chord = $chordal_data | Where {$_.mode -eq "Ionian"}}
    if ($scale.type -eq "Minor"){$root_chord = $chordal_data | Where {$_.mode -eq "Aeolian"}}
    if ($scale.type -eq "Dim"){$root_chord = $chordal_data | Where {$_.mode -eq "Locrian"}}

    if ($scale.notes  -match "\wb"){
        $accidental = "b"
        $chromatic_array = 0..100 | foreach {@('A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab')}
    }

    if ($scale.notes  -match "\w#"){
        $accidental = "#"
        $chromatic_array = 0..100 | foreach {@('A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#')}
    }

   if (!$chromatic_array){
       $accidental = "#"
        $chromatic_array = 0..100 | foreach {@('A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#')}
    }

    $count = 0
    $chromatic_array | foreach {
        if ($_ -eq $scale.notes[0]){$root_index = $count}
        else {$count++}
    }

    $chord_base = [int]$root_chord.Chord_1.split('-')[0] + $root_index - 2
    $chordal_data | ForEach-Object {
        $current_mode = $_
        1..7 | foreach-object {
            $chord_num = $_
            $semitone_array = $current_mode."chord_$chord_num".split('-')

            $semitone_array += ':'

            if ($semitone_array[0] -eq 23){
                $firstDiff = $semitone_array[1] - -1 #calibrated to map, dont touch
            }
            else {
                $firstDiff = $semitone_array[1] - $semitone_array[0]
            }
            $secondDiff = $semitone_array[2] - $semitone_array[1]

            0..4 | foreach-object {
                    if ($_ -eq 4){
                        if ($firstDiff -gt $secondDiff){$semitone_array[$_] = Get-ChordalNumeral -inputSymbol "^" -chord_num $chord_num}
                        if ($firstDiff -lt $secondDiff){$semitone_array[$_] = Get-ChordalNumeral -inputSymbol "." -chord_num $chord_num}
                        if ($firstDiff -eq $secondDiff){$semitone_array[$_] = Get-ChordalNumeral -inputSymbol "!" -chord_num $chord_num}
                    }
                    else {
                        $note_step = [int]$chord_base + [int]$semitone_array[$_]
                        $note_output = $chromatic_array[$note_step]
                        $semitone_array[$_] = $note_output
                    }
            }
            $string = $semitone_array -join "-"
            $current_mode."chord_$chord_num" = $string
        }
        $current_mode
    }
}
