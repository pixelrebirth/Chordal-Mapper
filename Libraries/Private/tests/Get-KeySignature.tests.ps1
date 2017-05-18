. ./Libraries/Private/Get-KeyScale.ps1
. ./Libraries/Private/Get-KeySignature.ps1

$KeyScale = get-keyscale -rootkey D -scaletype major

Describe "Get-KeySignature" {
    it "Should return F# on D Major scale" {
        (Get-KeySignature -KeyScale $KeyScale)[0] | Should be "F#"
    }
}