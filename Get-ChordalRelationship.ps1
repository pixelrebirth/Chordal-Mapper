param (
    [Parameter(Mandatory=$true)][ValidateSet("A#","B#", "C#", "D#", "E#", "F#", "G#", "A","B", "C", "D", "E", "F", "G", "Ab","Bb", "Cb", "Db", "Eb", "Fb", "Gb")]$root_key,
    [Parameter(Mandatory=$true)][ValidateSet("Major","Minor","Dim")]$scale_type
)

import-module .\Chordal-Mapper.psd1 -force

$scale = Get-KeyScale -root_key $root_key -scale_type $scale_type
$signature = Get-KeySignature -key_scale $scale
Write-Host "
    Scale: $(($scale.notes) -join("-"))
    Signature: $(($signature) -join("-"))
"

try {
    $chordal_map = Convert-ChordalMap -scale $scale
}
catch {$error.exception.message ; exit 1}
# $chordal_map | select Chord_1,Chord_2,Chord_3,Chord_4,Chord_5,Chord_6,Chord_7,Mode,Mood,ScaleType

if ($scale.type -eq "Major"){$NextChord = $chordal_map | Where {$_.mode -eq "Ionian"}}
if ($scale.type -eq "Minor"){$NextChord = $chordal_map | Where {$_.mode -eq "Aeolian"}}
if ($scale.type -eq "Dim"){$NextChord = $chordal_map | Where {$_.mode -eq "Locrian"}}
$chords = $chordal_map | where {$_."Chord_1" -match $($NextChord."Chord_1")}
$progression = @()

$progression += $NextChord.Chord_1
$choice = 1

1..4 | foreach {
    $chords | select  Mood,Chord_1,Chord_2,Chord_3,Chord_4,Chord_5,Chord_6,Chord_7 | ft
    $mood = Read-Host "Mood $_"
    $NextChord = $chordal_map | where {$_.mood -match $mood}
    $NextNumber = Get-NextChord -CurrentChord $choice
    $choice = Read-Host "Next Chord: $NextNumber"
    $progression += $NextChord."Chord_$choice"
    $chords = $chordal_map | where {$_."Chord_$choice" -match $($NextChord."Chord_$choice")}
}

$progression