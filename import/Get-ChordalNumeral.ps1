function Get-ChordalNumeral {
    param ($inputSymbol,$chord_num)
    If ($inputSymbol -eq "^"){
        switch ($chord_num){
            "1"  {"I"}
            "2"  {"II"}
            "3"  {"III"}
            "4"  {"IV"}
            "5"  {"V"}
            "6"  {"VI"}
            "7"  {"VII"}
        }
    }
        If ($inputSymbol -eq "."){
        switch ($chord_num){
            "1"  {"i"}
            "2"  {"ii"}
            "3"  {"iii"}
            "4"  {"iv"}
            "5"  {"v"}
            "6"  {"vi"}
            "7"  {"vii"}
        }
    }
        If ($inputSymbol -eq "!"){
        switch ($chord_num){
            "1"  {"i*"}
            "2"  {"ii*"}
            "3"  {"iii*"}
            "4"  {"iv*"}
            "5"  {"v*"}
            "6"  {"vi*"}
            "7"  {"vii*"}
        }
    }
}