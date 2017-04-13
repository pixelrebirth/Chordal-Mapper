param (
    [cmdletbinding(DefaultParameterSetName='Modes')]

    [Parameter(ParameterSetName="Modes")]
    [ValidateSet('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')]$primary_mode,
    [Parameter(ParameterSetName="Modes")]
    [ValidateSet('Lydian','Ionian','Mixolydian','Dorian','Aeolian','Phrygian','Locrian')]$secondary_mode,

    [Parameter(ParameterSetName="Moods")]
    [ValidateSet('Very bright, Congradulatory','Love songs, uplifting, happy','Optimistic Realist','Serious/Attentive',
        'Sad/Depressed','Exotic/Different','Unsettling and Unruly')]$mood_primary,
    [Parameter(ParameterSetName="Moods")]
    [ValidateSet('Very bright, Congradulatory','Love songs, uplifting, happy','Optimistic Realist','Serious/Attentive',
        'Sad/Depressed','Exotic/Different','Unsettling and Unruly')]$mood_secondary
)

. $PSScriptRoot/functions.ps1

$chordal_data = Import-Csv -Path "Chords by Mode - Chordal Notes.csv"
$base_chord = $chordal_data | Where-Object {$_.mode -eq "Ionian"}

if ($PScmdlet.ParameterSetName -eq "Modes"){
    $primary_chord = $chordal_data | Where-Object {$_.mode -eq $primary_mode}
    $secondary_chord = $chordal_data | Where-Object {$_.mode -eq $secondary_mode}
}

if ($PScmdlet.ParameterSetName -eq "Moods"){
    $primary_chord = $chordal_data | Where-Object {$_.mood -eq $mood_primary}
    $secondary_chord = $chordal_data | Where-Object {$_.mood -eq $mood_secondary}
}

$output = @()
$output += Convert-ChordalMap -chord $primary_chord -primary $true

$diff = $primary_chord.Offset - $secondary_chord.Offset
$output += Convert-ChordalMap -chord $secondary_chord -diff $diff

return $output | Format-Table
