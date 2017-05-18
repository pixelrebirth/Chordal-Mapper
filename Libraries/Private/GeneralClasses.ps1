class Mode {
    $Type
    $Name
    $Accidentals
    $Voice
    $Mood
    
    Mode ($Name) {
        $this.Name = $Name
        $this.Accidentals = switch ($Name) {
            "Lydian"        {"---#---"}
            "Ionian"        {"-------"}
            "Mixolydian"    {"------b"}
            "Dorian"        {"--b----b"}
            "Aeolian"       {"--b---b-b"}
            "Phrygian"      {"-b-b---b-b"}
            "Locrian"       {"-b-b--b-b-b"}
        }
        $this.Type = switch -regex ($Name) {
            "Lydian|Ionian|Mixolydian"  {"Major"}
            "Dorian|Aeolian|Phrygian"   {"Minor"}
            "Locrian"                   {"Dim"}
        }
        $this.Voice = switch ($Name) {
            "Ionian"     {@("I", "ii", "iii", "IV", "V", "vi", "vii*")}
            "Dorian"     {@("i", "ii", "III", "IV", "v", "vi*", "VII")}
            "Phrygian"   {@("i", "II", "III", "iv", "v*", "VI", "vii")}
            "Lydian"     {@("I", "II", "iii", "iv*", "V", "vi", "vii")}
            "Mixolydian" {@("I", "ii", "iii*", "IV", "v", "vi", "VII")}
            "Aeolian"    {@("i", "ii*", "III", "iv", "v", "VI", "VII")}
            "Locrian"    {@("i*", "II", "iii", "iv", "V", "VI", "vii")}
        }
        $this.Mood = switch ($Name) {
            "Lydian"     {"Ethereal"}
            "Ionian"     {"Happy"}
            "Mixolydian" {"Peaceful"}
            "Dorian"     {"Serious"}
            "Aeolian"    {"Sad"}
            "Phrygian"   {"Exotic"}
            "Locrian"    {"Unsettling"}
        }
    }
    [array] GetScale ($InputScale) {
        $Count = 0
        $OutputScale = Get-KeyScale -rootkey $InputScale.Notes[0] -scaleType $InputScale.Type
        foreach ($Accident in $this.Accidentals.split("-")) {
            $EachNote = $InputScale.Notes[$Count]
            if ($Accident -match "#|b") {
                if ($Accident -eq "#") {
                    if ($EachNote -match "^\wb$") {
                        $OutputScale.Notes[$Count] = $EachNote.substring(0, 1)
                    }
                    else {
                        $OutputScale.Notes[$Count] = "$EachNote$Accident" 
                    }
                }
                if ($Accident -eq "b") {
                    if ($EachNote -match "^\w#$") {
                        $OutputScale.Notes[$Count] = $EachNote.substring(0, 1)
                    }
                    else {
                        $OutputScale.Notes[$Count] = "$EachNote$Accident" 
                    }
                }
            }
            $Count++
        }
        return $OutputScale
    }
}

class Progression {
    [array]$Chords
    [string]$Numerals

    Progression () {
        $this.Chords = @()
    }
    [void] Add ($InputChord) {
        $this.Chords += $InputChord
        $this.Numerals = ($this.Chords.split('-') | where {$_ -match "i|v"}) -join ("-")
    }
}

class ChordMap {
    $Chord_1
    $Chord_2
    $Chord_3
    $Chord_4
    $Chord_5
    $Chord_6
    $Chord_7
    $Mood
    $Mode
    $Type
    $Index
}

class KeyScale {
    $Notes
    $Type
    $Offset
}