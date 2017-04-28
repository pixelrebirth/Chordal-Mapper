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

if ($scale.type -eq "Major"){$NextChord = $chordal_map | Where {$_.mode -eq "Ionian"}}
if ($scale.type -eq "Minor"){$NextChord = $chordal_map | Where {$_.mode -eq "Aeolian"}}
if ($scale.type -eq "Dim"){$NextChord = $chordal_map | Where {$_.mode -eq "Locrian"}}
$chords = $chordal_map | where {$_."Chord_1" -match $($NextChord."Chord_1")}
$progression = @()

try {[int]$final_chord = Read-Host "Number Chords in Progression"} catch {Write-Host "Must be integer."}
$final_chord = $final_chord - 1


$progression += $NextChord.Chord_1
$choice = 1
clear

Write-host "Starting Chord: $($NextChord.Chord_1),$($NextChord.mode) and of $($NextChord.type) type"

1..$final_chord | foreach {
    if ($final_chord-1 -eq $_){Write-Host "`n`tFirst Cadence Chord" -f red ; Get-Cadence}
    if ($final_chord -eq $_){Write-Host "`n`tFinal Cadence Chord ($choice)" -f red ; Get-Cadence}
    $chords | select  Mood,Chord_1,Chord_2,Chord_3,Chord_4,Chord_5,Chord_6,Chord_7 | ft
    $mood = Read-Host "Mood Chord $($_ + 1)"
    $NextChord = $chordal_map | where {$_.mood -match $mood}
    $NextNumber = Get-NextChord -CurrentChord $choice
    $choice = Read-Host "Next Chord: $NextNumber"
    $progression += $NextChord."Chord_$choice"
    $chords = $chordal_map | where {$_."Chord_$choice" -match $($NextChord."Chord_$choice")}
    clear
}

Write-Host "
    Scale: $(($scale.notes) -join("-"))
    Signature: $(($signature) -join("-"))
"

$progression
"----------"
($progression.split('-') | where {$_ -match "i|v"}) -join ("-")
"---END---"