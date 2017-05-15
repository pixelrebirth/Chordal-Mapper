function Get-ChordProgression {
    <#
        .SYNOPSIS
        This cmdlet allows you to create unique and interesting chord progression using a multimode engine.
        
        .DESCRIPTION
        The cmdlet works by entering in the basic key signature of the piece.
        This is likely something like C Major (use that if you dont know) or A minor or C# minor.

        Once this has been input you will be presented with a chord chart based off your key.
        Using the chord chart, select the first chord by following the on screen instructions.

        The next chord is calculated to be a seamless progression from the last one if you follow the suggestions.
        The suggestions are NOT mandatory and you can override them as you see fit.
        
        .PARAMETER RootKey
        The RootKey is the key of the piece, include A-G and #/b variants
        
        .PARAMETER ScaleType
        The ScaleType is going to indicate what the key signature is for the piece.
        This completes the picture of KEY in a musical piece. This can be Major, Minor, or Dim
        
        .EXAMPLE
        Get-ChordProgression -RootKey C -ScaleType Major
        
        .EXAMPLE
        Get-ChordProgression -RootKey C# -ScaleType Minor

        .LINK
        https://github.com/pixelrebirth/Chordal-Mapper
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet(
            "A#",
            "B#", 
            "C#", 
            "D#", 
            "E#", 
            "F#", 
            "G#", 
            "A",
            "B", 
            "C", 
            "D", 
            "E", 
            "F", 
            "G", 
            "Ab",
            "Bb", 
            "Cb", 
            "Db", 
            "Eb", 
            "Fb", 
            "Gb"
        )
        ]
        [string]$RootKey,
        
        [Parameter(Mandatory = $true)]
        [ValidateSet("Major", "Minor", "Dim")]
        [string]$ScaleType
    )

    begin {
        $SongScale = Get-KeyScale -RootKey $RootKey -ScaleType $ScaleType
        $IonianScale = Get-KeyScale -RootKey $RootKey -ScaleType 'Major'
        $KeySignature = Get-KeySignature -KeyScale $SongScale

        try {
            $ChordalMap = Convert-ChordalMap -IonianScale $IonianScale
        }
        catch {
            Return $Error.Exception.Message
        }

        Write-Verbose -message "Outputing chordal map object to stdout..."
        $ChordalMap
        $FilteredChords = $ChordalMap

        $ProgressionObject = New-Object -TypeName Progression

        $ChordNumber = 1
        $chordcounter = 0
        Clear-Host
    }

    process {
        while ($true) {
            Write-Host "
                Scale: $(($SongScale.notes) -join("-"))
                Signature: $(($KeySignature) -join("-"))
            "

            Write-Host -ForegroundColor yellow "
                Cadence Chart
                --------------------------
                1-5  = Imperfect --
                5-6  = Deceptive -
                2-5  = Half -
                4-5  = Imperfect -
                Rest = Rhythmic +
                7-1  = Backdoor +
                4-1  = Plagal +
                5-1  = Perfect ++
            "

            Write-host "`nProgression:`n"
            $ProgressionObject.chords

            $FilteredChords | Select-Object Index, Chord_1, Chord_2, Chord_3, Chord_4, Chord_5, Chord_6, Chord_7, Mode, Mood | Format-Table
            $ChordSuggestions = Get-NextChord -CurrentChord $ChordNumber

            $ChordNumber = Read-Host "Next Chord Number (Column in table) (x to end progression)`nSuggestions: $ChordSuggestions"
            if ($ChordNumber -eq "x") {
                Write-Verbose -message "Breaking the loop that holds the program open asking for chords."
                Break
            }

            $RowIndex = Read-Host "Choose Index Number (Row in table) for progression"
            
            $NextChord = $ChordalMap | where {$Input.index -eq $RowIndex}
            $ProgressionObject.add($NextChord."Chord_$ChordNumber") | out-null
            $FilteredChords = $ChordalMap | where {$Input."Chord_$ChordNumber" -match $($NextChord."Chord_$ChordNumber")}
            Clear-Host
        }
    }

    end {
        Clear-Host

        Write-Host ""
        Write-Host "Key:        $($SongScale.notes[0])"
        Write-Host "Type:       $($SongScale.type)"
        Write-Host "Scale:      $(($SongScale.notes) -join("-"))"
        Write-Host "Signature:  $(($KeySignature) -join("-"))"
        Write-Host "Progression:   $($ProgressionObject.numerals)"
        Write-Host ""
        
        $ProgressionObject.chords
        Write-Host ""
    }
}
