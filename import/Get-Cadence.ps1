function Get-Cadence {
    write-host "
        1) V-I  : Perfect
        2) IV-I : Plagal
        3) II-V : Imperfect
        4) IV-V : Imperfect
        5) I-V  : Imperfect
        6) V-VI : Deceptive
        7) VII-I: Backdoor"
    
    $cadance = Read-Host Choose a cadance by number
    switch ($cadance) {
        "1" {"5-1"}
        "2" {"4-1"}
        "3" {"2-5"}
        "4" {"4-5"}
        "6" {"5-6"}
        "7" {"7-1"}
    }
}