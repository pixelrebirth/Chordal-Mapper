param (
    [cmdletbinding()]
    [ValidateSet('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')]$primary_mode,
    [ValidateSet('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')]$secondary_mode
)

. $PSScriptRoot/functions.ps1
$chordal_data = Import-Csv -Path "Chords by Mode - Chordal Notes.csv"

$base_chord = $chordal_data | Where-Object {$_.mode -eq "Ionian"}
$primary_chord = $chordal_data | Where-Object {$_.mode -eq $primary_mode}
$secondary_chord = $chordal_data | Where-Object {$_.mode -eq $secondary_mode}

Convert-ChordalMap -chord $primary_chord -primary $true

$diff = $primary_chord.Offset - $secondary_chord.Offset
Convert-ChordalMap -chord $secondary_chord -diff $diff
