function Convert-ChordalMap {
    param ($chord,$diff = 0)

    $Notes = ('A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab',
        'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab',
        'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab'
    )

    $chord_base = [int]$chord.Chord_1.split('-')[0] + [int]$chord.Offset - 3 + $diff

    1..7 | foreach-object {
        $chord_num = $_
        $array = $chord."chord_$chord_num".split('-')

        0..3 | foreach-object {
                $note_step = [int]$chord_base + [int]$array[$_]
                $array[$_] = $notes[$note_step]
        }
        $string = $array -join "-"
        $chord."chord_$chord_num" = $string
    }
    return $chord
}
