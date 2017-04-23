function Convert-ChordalMap {
    param ($chord,$scale)

    $chord_base = [int]$chord.Chord_1.split('-')[0] + [int]$chord.Offset - 3 + $diff

    # replace old flat/sharp and check scale for which one and root note to set DIFF

    1..7 | foreach-object {
        $chord_num = $_
        $array = $chord."chord_$chord_num".split('-')

        $array += ':'

        if ($array[0] -eq 23){
            $firstDiff = $array[1] - -1 #calibrated to map
        }
        else {
            $firstDiff = $array[1] - $array[0]
        }
        $secondDiff = $array[2] - $array[1]

        0..4 | foreach-object {
                if ($_ -eq 4){
                    if ($firstDiff -gt $secondDiff){$array[$_] = "^"}
                    if ($firstDiff -lt $secondDiff){$array[$_] = "."}
                    if ($firstDiff -eq $secondDiff){$array[$_] = "!"}
                }
                else {
                    $note_step = [int]$chord_base + [int]$array[$_]
                    $array[$_] = $notes[$note_step]
                }
        }
        $string = $array -join "-"
        $chord."chord_$chord_num" = $string
    }
    return $chord
}
