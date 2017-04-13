function Set-FlatSharp {
    param ($inputLetter,$after)

    if ($inputLetter -cmatch "b$"){return $after + "b"}
    if ($inputLetter -cmatch "\#$"){return $after + "#"}
    return $after
}

function Convert-ChordalMap {
    param (
        $chord,
        $diff = 0,
        $primary
    )

    $Notes = ("A", "B", "C", "D", "E", "F", "G",
        "A", "B", "C", "D", "E", "F", "G",
        "A", "B", "C", "D", "E", "F", "G"
    )

    $Notes_Steps = ('A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab',
        'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab'
    )

    1..7 | foreach-object {
        $chord_num = $_
        $interval = $_ - 1
        $array = $chord."chord_$chord_num".split('-')

        $count = 0
        0..3 | foreach-object {
            $after = $Notes[$interval+$count+$diff+$chord.Offset]

            if ($primary){
                $array[$_] = $after
            }
            else {
                $array[$_] = Set-FlatSharp -after $after -inputLetter $array[$_]
            }

            $count += 2
        }
        $string = $array -join "-"
        $chord."chord_$chord_num" = $string
    }
    return $chord
}
