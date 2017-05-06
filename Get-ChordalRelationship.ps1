param (
    [Parameter(Mandatory=$true)][ValidateSet("A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D", "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb")]$root_key,
    [Parameter(Mandatory=$true)][ValidateSet("Major","Minor","Dim")]$scale_type
)

import-module .\Chordal-Mapper.psd1 -force

$song_scale = Get-KeyScale -root_key $root_key -scale_type $scale_type
$ionian_scale = Get-KeyScale -root_key $root_key -scale_type 'Major'
$signature = Get-KeySignature -key_scale $song_scale

Write-Host "
    Scale: $(($song_scale.notes) -join("-"))
    Signature: $(($signature) -join("-"))
"

try {
    $chordal_map = Convert-ChordalMap -ionian_scale $ionian_scale
}
catch {
    $error.exception.message
    exit 1
}

$chordal_map
$chords = $chordal_map

$progression = New-ChordProgression

$choice = 1
$chord_counter = 0
clear

while ($true) {
    $chord_counter++
    Write-host "`nPrevious Chords:`n"
    $progression.chords
    Write-Host "`n`tCadence Chart" -f yellow
    Get-Cadence

    $chords | select  Index,Chord_1,Chord_2,Chord_3,Chord_4,Chord_5,Chord_6,Chord_7,Mode,Mood | ft
    $NextNumber = Get-NextChord -CurrentChord $choice

    $choice = Read-Host "Next Chord Number (column) (x to quit): Chord_<$NextNumber>"
    if ($choice -eq "x"){break}

    $index = Read-Host "Choose Index Number (row) for progression: $($chord_counter + 1)"
    
    $NextChord = $chordal_map | where {$_.index -eq $index}
    $progression.add($NextChord."Chord_$choice") | out-null
    $chords = $chordal_map | where {$_."Chord_$choice" -match $($NextChord."Chord_$choice")}
    clear
}

Write-Host "
Key: $($song_scale.notes[0])
Type: $($song_scale.type)
Scale: $(($song_scale.notes) -join("-"))
Signature: $(($signature) -join("-"))

----------
Note Progression:"
$progression.chords

Write-Host "`n----------
Numeral Progression:"
$progression.numerals

Write-Host "`n---END---"
