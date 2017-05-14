function Convert-ChordalMap {
    param ($IonianScale)

    $ModeNames = @('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')
    $AllChords = @()
    $IndexCount = 0

    foreach ($EachName in $ModeNames){
        $IndexCount++
        $Notes = @()
        $CurrentMode = [Mode]::new($EachName)
        $ModeScale = $CurrentMode.GetScale($IonianScale)
        $ChordPerMode = [ChordMap]::new()
        1..5 | foreach {$Notes += $ModeScale.Notes}
        
        1..7 | foreach {
            $Num = $_
            $BaseNote = $Num - 1
            $ChordPerMode."chord_$Num" = $($Notes[$BaseNote]) + "-" + $($Notes[($BaseNote+2)]) + "-" + $($Notes[($BaseNote+4)]) + "-" + $($Notes[($BaseNote+6)]) + "-" + $($CurrentMode.voice[$BaseNote])
            $ChordPerMode.index = [string]$IndexCount
        }
        $ChordPerMode.type = $CurrentMode.type
        $ChordPerMode.mood = $CurrentMode.mood
        $ChordPerMode.mode = $CurrentMode.name
        $AllChords += $ChordPerMode
    }
    return $AllChords
}
