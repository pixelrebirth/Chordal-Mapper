function Set-FlatSharp {
    param ($inputLetter,$after)

    if ($inputLetter -cmatch "b$"){return $after + "b"}
    if ($inputLetter -cmatch "\#$"){return $after + "#"}
    return $after
}

$primary_mode = "Ionian"
$secondary_mode = "Dorian"

$chordal_data = Import-Csv -Path "Chords by Mode - Chordal Notes.csv"
$base_chord = $chordal_data | Where-Object {$_.mode -eq "Ionian"}
$primary_chord = $chordal_data | Where-Object {$_.mode -eq $primary_mode}
$secondary_chord = $chordal_data | Where-Object {$_.mode -eq $secondary_mode}

$AtoG_All = ("A", "B", "C", "D", "E", "F", "G", "A", "B", "C", "D", "E", "F", "G", "A", "B", "C", "D", "E", "F", "G")
$CtoB_All = ("C", "D", "E", "F", "G", "A", "B", "C", "D", "E", "F", "G", "A", "B")
# $GtoA = ("G", "F", "E", "D", "C", "B", "A")
# $CtoD = ("C", "B", "A", "G", "F", "E", "D")
# $CtoD_All = ("C", "B", "A", "G", "F", "E", "D", "C", "B", "A", "G", "F", "E", "D")

1..7 | foreach-object {
    $chord_num = $_
    $interval = $_ - 1
    $array = $primary_chord."chord_$chord_num".split('-')
    $after = $AtoG_All[$interval+$primary_chord.Offset]
    $array[0] = $after
    $after = $AtoG_All[$interval+2+$primary_chord.Offset]
    $array[1] = $after
    $after = $AtoG_All[$interval+4+$primary_chord.Offset]
    $array[2] = $after
    $after = $AtoG_All[$interval+6+$primary_chord.Offset]
    $array[3] = $after
    $string = $array -join "-"
    $primary_chord."chord_$chord_num" = $string
}
$primary_chord

$diff = $primary_chord.Offset - $secondary_chord.Offset

1..7 | foreach-object {
    $chord_num = $_
    $interval = $_ - 1
    $array = $secondary_chord."chord_$chord_num".split('-')
    $after = $AtoG_All[$interval+$diff+$secondary_chord.Offset]
    $array[0] = Set-FlatSharp -after $after -inputLetter $array[0]
    $after = $AtoG_All[$interval+$diff+2+$secondary_chord.Offset]
    $array[1] = Set-FlatSharp -after $after -input $array[1]
    $after = $AtoG_All[$interval+$diff+4+$secondary_chord.Offset]
    $array[2] = Set-FlatSharp -after $after -input $array[2]
    $after = $AtoG_All[$interval+$diff+6+$secondary_chord.Offset]
    $array[3] = Set-FlatSharp -after $after -input $array[3]
    $string = $array -join "-"
    $secondary_chord."chord_$chord_num" = $string
}
$secondary_chord
