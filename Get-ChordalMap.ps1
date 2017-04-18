# function Get-ChordalMap {
    param (
        [CmdletBinding()]
        [ValidateSet("C","G", "D", "A", "E", "B", "Cb", "Gb", "F#", "Db", "C#", "Ab", "Eb", "Bb", "F")]$root_key,
        [ValidateSet("Major","Minor","Dim")]$scale_type
    )

    $chordal_data = Import-Csv -Path "Chords by Mode - Step Sheet.csv"
    $modes = $chordal_data.Mode
    $root_notes = @("C","G", "D", "A", "E", "B", "Cb", "Gb", "F#", "Db", "C#", "Ab", "Eb", "Bb", "F")

    if ($scale_type -eq "Major"){
        $key_signature = switch ($root_key) {
            "C" {""}
            "G" {"F♯,"}
            "D" {"F♯,C♯"}
            "A" {"F♯,C♯,G♯"}
            "E" {"F♯,C♯,G♯,D♯"}
            "B" {"F♯,C♯,G♯,D♯,A♯"}
            "Cb" {"Bb,Eb,Ab,Db,Gb,Cb,Fb"}
            "Gb" {"Bb,Eb,Ab,Db,Gb,Cb"}
            "F#" {"F♯,C♯,G♯,D♯,A♯,E♯"}
            "Db" {"Bb,Eb,Ab,Db,Gb"}
            "C#" {"F♯,C♯,G♯,D♯,A♯,E♯,B♯"}
            "Ab" {"Bb,Eb,Ab,Db"}
            "Eb" {"Bb,Eb,Ab"}
            "Bb" {"Bb,Eb"}
            "F" {"Bb"}
        }
    }

    if ($scale_type -eq "Minor"){
        $key_signature = switch ($root_key) {
            "A" {""}
            "E" {"F♯,"}
            "B" {"F♯,C♯"}
            "Cb" {"F♯,C♯,G♯"}
            "Gb" {"F♯,C♯,G♯,D♯"}
            "F#" {"F♯,C♯,G♯,D♯,A♯"}
            "Bb" {"Bb,Eb,Ab,Db,Gb,Cb,Fb"}
            "C#" {"Bb,Eb,Ab,Db,Gb,Cb"}
            "Ab" {"F♯,C♯,G♯,D♯,A♯,E♯"}
            "Eb" {"Bb,Eb,Ab,Db,Gb"}
            "Bb" {"F♯,C♯,G♯,D♯,A♯,E♯,B♯"}
            "F" {"Bb,Eb,Ab,Db"}
            "C" {"Bb,Eb,Ab"}
            "G" {"Bb,Eb"}
            "D" {"Bb"}
        }
    }


# }