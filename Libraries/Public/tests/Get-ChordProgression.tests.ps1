. ./Libraries/Public/Get-ChordProgression.ps1
. ./Libraries/Private/Get-KeyScale.ps1
. ./Libraries/Private/Get-KeySignature.ps1
. ./Libraries/Private/Convert-ChordalMap.ps1
. ./Libraries/Private/Get-NextChord.ps1
. ./Libraries/Private/GeneralClasses.ps1
function Write-Host {}
function Clear-Host {}

describe "Get-ChordProgression" {
    mock Read-Host -ParameterFilter {$prompt -match "Next Chord Number "} -mock {"1"}
    mock Read-Host -ParameterFilter {$prompt -match "Choose Index Number "} -mock {"1"}
    mock Read-Host -ParameterFilter {$prompt -match "Would you like to end the "} -mock {"x"}

    it "Should Succeed and output" {
        (Get-ChordProgression -RootKey C -ScaleType Major)[0] | should be "ChordMap"
    }

    it "should not fail" {
        mock Convert-ChordalMap {throw "Yaks"}
        {Get-ChordProgression -RootKey C -ScaleType Major} | should throw
    }
}