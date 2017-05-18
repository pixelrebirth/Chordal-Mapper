. ./Libraries/Private/GeneralClasses.ps1
. ./Libraries/Private/Get-KeyScale.ps1

$modes = @("Lydian",
    "Ionian",
    "Mixolydian",
    "Dorian",
    "Aeolian",
    "Phrygian",
    "Locrian")

$minorscale = Get-KeyScale -RootKey Ab -ScaleType Minor
$majorscale = Get-KeyScale -RootKey 'C#' -ScaleType Major

Describe "GeneralClasses" {
    Context "Mode" {
        foreach ($mode in $modes){
            it "Should create a mode object on instantiation of $mode" {
                (New-Object -TypeName Mode -ArgumentList $mode).name | should be $mode
            }
        }

        foreach ($mode in $modes){
            it "Should be able to GetScale with Sharps in $mode" {
                $mode = New-Object -TypeName Mode -ArgumentList $mode
                $mode.GetScale($majorscale) | should be "KeyScale"
            }
        
            it "Should be able to GetScale with Flats in $mode" {
                $mode = New-Object -TypeName Mode -ArgumentList $mode
                $mode.GetScale($minorscale) | should be "KeyScale"
            }
        }
    }

    Context "ChordMap" {
        it "Should create a ChordMap type object" {
            $ChordMap = New-Object -TypeName ChordMap
            {$ChordMap.Mood = "thing"} | should not throw
        }
    }

    Context "KeyScale" {
        it "Should create a KeyScale type object" {
            $KeyScale = New-Object -TypeName KeyScale
            {$KeyScale.type = "thing"} | should not throw
        }
    }

    Context "Progression" {
        it "Should create a Progression type object" {
            $Progression = New-Object -TypeName Progression
            {$Progression.numerals = "thing"} | should not throw
        }

        it "Should create add chord to Progression type object" {
            $Progression = New-Object -TypeName Progression
            $Progression.Add('F-A-C-E')
            $Progression.chords[0] | should be 'F-A-C-E'
        }
    }
}
