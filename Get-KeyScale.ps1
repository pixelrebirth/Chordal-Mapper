function Get-KeyScale {
    param (
        [CmdletBinding()]
        [ValidateSet("A#","B#", "D#", "E#", "Fb", "G#", "C","G", "D", "A", "E", "B", "Cb", "Gb", "F#", "Db", "C#", "Ab", "Eb", "Bb", "F")]$root_key,
        [ValidateSet("Major","Minor","Dim")]$scale_type
    )

    $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    $modes = $chordal_data.Mode

    if ($scale_type -eq "Major"){
        $root_number = switch ($root_key) {
            "C" {0}
            "G" {1}
            "D" {2}
            "A" {3}
            "E" {4}
            "B" {5}
            "F#" {6}
            "C#" {7}
            "Cb" {8}
            "Gb" {9}
            "Db" {10}
            "Ab" {11}
            "Eb" {12}
            "Bb" {13}
            "F" {14}
            default {-1}
        }
    }
    
    if ($scale_type -eq "Minor"){
        $root_number = switch ($root_key) {
            "A" {0}
            "E" {1}
            "B" {2}
            "F#" {3}
            "C#" {4}
            "G#" {5}
            "D#" {6}
            "A#" {7}
            "Ab" {8}
            "Eb" {9}
            "Bb" {10}
            "F" {11}
            "C" {12}
            "G" {13}
            "D" {14}
            default {-1}
        }
    }

    if ($scale_type -eq "Dim"){
        $root_number = switch ($root_key) {
            "B" {0}
            "F#" {1}
            "C#" {2}
            "G#" {3}
            "D#" {4}
            "A#" {5}
            "E#" {6}
            "B#" {7}
            "Bb" {8}
            "F" {9}
            "C" {10}
            "G" {11}
            "D" {12}
            "A" {13}
            "E" {14}
            default {-1}
        }
    }

    $key_diff = $root_number
    if ($key_diff -gt 14){$key_diff = $key_diff - 14}

    $notes_map =  switch ($key_diff) {
        "0" {"F,C,G,D,A,E,B"}
        "1" {"F#,C,G,D,A,E,B"}
        "2" {"F#,C#,G,D,A,E,B"}
        "3" {"F#,C#,G#,D,A,E,B"}
        "4" {"F#,C#,G#,D#,A,E,B"}
        "5" {"F#,C#,G#,D#,A#,E,B"}
        "6" {"F#,C#,G#,D#,A#,E#,B"}
        "7" {"F#,C#,G#,D#,A#,E#,B#"}
        "8" {"Bb,Eb,Ab,Db,Gb,Cb,Fb"}
        "9" {"Bb,Eb,Ab,Db,Gb,Cb,F"}
        "10" {"Bb,Eb,Ab,Db,Gb,C,F"}
        "11" {"Bb,Eb,Ab,Db,G,C,F"}
        "12" {"Bb,Eb,Ab,D,G,C,F"}
        "13" {"Bb,Eb,A,D,G,C,F"}
        "14" {"Bb,E,A,D,G,C,F"}
        default {"Key: $root_key not on circle of fifths for scale: $scale_type"}
    }

    $count = 0
    $scale_notes = [array]$notes_map.split(",") | sort
    foreach ($note in [array]$scale_notes.split(",")){
        if ($note -eq $root_key){
            break
        }
        $count++
    }

    $output_notes = $scale_notes[$count..6] + $scale_notes[0..$count]

    $output_notes.split(",")
}