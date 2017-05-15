function Get-NextChord {
    param ($CurrentChord)

    switch ($CurrentChord) {
        "1" {'1-2-3-4-5-6-7'}
        "2" {'4-5-7'}
        "3" {'4-6'}
        "4" {'1-2-5-7'}
        "5" {'1-6-7'}
        "6" {'2-4'}
        "7" {'1-6'}
    } 
}
