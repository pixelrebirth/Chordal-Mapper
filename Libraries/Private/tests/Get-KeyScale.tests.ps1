. ./Libraries/Private/Get-KeyScale.ps1

$MajorRoots = @("C",
            "G",
            "D",
            "A",
            "E",
            "B",
            "F#",
            "C#",
            "Cb",
            "Gb",
            "Db",
            "Ab",
            "Eb",
            "Bb",
            "F")

$MinorRoots = @("A",
            "E",
            "B",
            "F#",
            "C#",
            "G#",
            "D#",
            "A#",
            "Ab",
            "Eb",
            "Bb",
            "F",
            "C",
            "G",
            "D")

$DimRoots = @("B",
            "F#",
            "C#",
            "G#",
            "D#",
            "A#",
            "E#",
            "B#",
            "Bb",
            "F",
            "C",
            "G",
            "D",
            "A",
            "E")

$ScaleTypes = @("Major", "Minor", "Dim")
describe "Get-KeyScale" {
    foreach ($root in $MajorRoots){
        It "Should return a scale per proper note $root in Major" {
                (Get-KeyScale -RootKey $root -ScaleType Major).notes[0] | should be $root
        }
    }
    
    foreach ($root in $MinorRoots){
        It "Should return a scale per proper note $root in Major" {
                (Get-KeyScale -RootKey $root -ScaleType Minor).notes[0] | should be $root
        }
    }
    
    foreach ($root in $DimRoots){
        It "Should return a scale per proper note $root in Major" {
                (Get-KeyScale -RootKey $root -ScaleType Dim).notes[0] | should be $root
        }
    }

    It "Should throw if root is not in Major Key" {
        {Get-KeyScale -RootKey 'A#' -ScaleType Major} | should throw
    }
    
    It "Should throw if root is not in Minor Key" {
        {Get-KeyScale -RootKey 'B#' -ScaleType Minor} | should throw
    }
    
    It "Should throw if root is not in Dim Key" {
        {Get-KeyScale -RootKey 'Ab' -ScaleType Dim} | should throw
    }
}