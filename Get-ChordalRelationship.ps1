param (
    [Parameter(Mandatory=$true)][ValidateSet("A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D", "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb")]$root_key,
    [Parameter(Mandatory=$true)][ValidateSet("Major","Minor","Dim")]$scale_type
)

import-module .\Chordal-Mapper.psd1 -force

$song_scale = Get-KeyScale -root_key $root_key -scale_type $scale_type
$signature = Get-KeySignature -key_scale $song_scale
Write-Host "
    Scale: $(($song_scale.notes) -join("-"))
    Signature: $(($signature) -join("-"))
"

try {
    $chordal_map = Convert-ChordalMap -song_scale $song_scale
}
catch {
    $error.exception.message
    exit 1
}

if ($song_scale.type -eq "Major"){$NextChord = $chordal_map | Where {$_.mode -eq "Ionian"}}
if ($song_scale.type -eq "Minor"){$NextChord = $chordal_map | Where {$_.mode -eq "Aeolian"}}
if ($song_scale.type -eq "Dim"){$NextChord = $chordal_map | Where {$_.mode -eq "Locrian"}}

$chords = $chordal_map | where {$_."Chord_1" -match $($NextChord."Chord_1")}
$progression = [Progression]::new()

$progression.add($NextChord.Chord_1)
$choice = 1
$chord_counter = 0
clear

while ($true) {
    $chord_counter++
    Write-host "`nPrevious Chords:`n"
    $Progression
    Write-Host "`n`tCadence Chart" -f yellow
    Get-Cadence

    $chords | select  Mode,Chord_1,Chord_2,Chord_3,Chord_4,Chord_5,Chord_6,Chord_7,Mood | ft
    $NextNumber = Get-NextChord -CurrentChord $choice

    $choice = Read-Host "Next Chord (x to quit): $NextNumber"
    if ($choice -eq "x"){break}

    $mode = Read-Host "Mode Chord $($chord_counter + 1)"
    
    $NextChord = $chordal_map | where {$_.mode-match $mode}
    $progression.add($NextChord."Chord_$choice")
    $chords = $chordal_map | where {$_."Chord_$choice" -match $($NextChord."Chord_$choice")}
    clear
}

Write-Host "
Scale: $(($song_scale.notes) -join("-"))
Signature: $(($signature) -join("-"))

----------
Note Progression:"
$progression.chords

Write-Host "----------
Numeral Progression:"
$progression.numerals

Write-Host "---END---"
