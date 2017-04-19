function Get-KeySignature {
    param (
        [CmdletBinding()]
        [ValidateSet("C","G", "D", "A", "E", "B", "Cb", "Gb", "F#", "Db", "C#", "Ab", "Eb", "Bb", "F")]$root_key,
        [ValidateSet("Major","Minor","Dim")]$scale_type
    )

    $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    $modes = $chordal_data.Mode
    $root_notes = @("C","G", "D", "A", "E", "B", "Cb", "Gb", "F#", "Db", "C#", "Ab", "Eb", "Bb", "F")

    $root_number = switch ($root_key) {
        "C" {"0"}
        "G" {"1"}
        "D" {"2"}
        "A" {"3"}
        "E" {"4"}
        "B" {"5"}
        "Cb" {"6"}
        "Gb" {"7"}
        "F#" {"8"}
        "Db" {"9"}
        "C#" {"10"}
        "Ab" {"11"}
        "Eb" {"12"}
        "Bb" {"13"}
        "F" {"14"}
    }
    
    $root_offset = switch ($scale_type){
        "Major" {0}
        "Dim" {-5}
        "Minor" {-3}
    }

    $key_diff = [int]$root_number + [int]$root_offset
    if ($key_diff -gt 14){$key_diff = $key_diff - 14}

    Write-Verbose "Key_diff: $key_diff, $root_number, $root_offset"
    $key_signature =  switch ($key_diff) {
        "0" {""}
        "1" {"F#"}
        "2" {"F#,C#"}
        "3" {"F#,C#,G#"}
        "4" {"F#,C#,G#,D#"}
        "5" {"F#,C#,G#,D#,A#"}
        "6" {"Bb,Eb,Ab,Db,Gb,Cb,Fb"}
        "7" {"Bb,Eb,Ab,Db,Gb,Cb"}
        "8" {"F#,C#,G#,D#,A#,E#"}
        "9" {"Bb,Eb,Ab,Db,Gb"}
        "10" {"F#,C#,G#,D#,A#,E#,B#"}
        "11" {"Bb,Eb,Ab,Db"}
        "12" {"Bb,Eb,Ab"}
        "13" {"Bb,Eb"}
        "14" {"Bb"}
    }

    $key_signature.split(",") | Sort
}