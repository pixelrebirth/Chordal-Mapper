function Get-KeyScale {
    param (
        [CmdletBinding()]
        [ValidateSet(
            "A#",
            "B#", 
            "C#", 
            "D#", 
            "E#", 
            "F#", 
            "G#", 
            "A",
            "B", 
            "C", 
            "D", 
            "E", 
            "F", 
            "G", 
            "Ab",
            "Bb", 
            "Cb", 
            "Db", 
            "Eb", 
            "Fb", 
            "Gb"
            )
        ]$RootKey,
        [ValidateSet("Major","Minor","Dim")]$ScaleType
    )

    if ($ScaleType -eq "Major"){
        $RootNumber = switch ($RootKey) {
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
    
    if ($ScaleType -eq "Minor"){
        $RootNumber = switch ($RootKey) {
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

    if ($ScaleType -eq "Dim"){
        $RootNumber = switch ($RootKey) {
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

    $KeyDiff = $RootNumber
    if ($KeyDiff -gt 14){$KeyDiff = $KeyDiff - 14}

    $Signature =  switch ($KeyDiff) {
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
        default {throw "Key: $RootKey not on circle of fifths for scale: $ScaleType" ; exit 1}
    }

    $Count = 0
    $ScaleNotes = [array]$Signature.split(",") | sort
    foreach ($note in [array]$ScaleNotes.split(",")){
        if ($note -eq $RootKey){
            break
        }
        $Count++
    }

    $Output = [KeyScale]::new()
    if ($Count -eq 0){
        $Output.notes = $ScaleNotes
    }
    else {
        $Output.notes = $ScaleNotes[$Count..6] + $ScaleNotes[0..$($Count-1)]
    }
    
    $Output.type = $ScaleType
    $Output.offset = $Count
    return $Output
}
