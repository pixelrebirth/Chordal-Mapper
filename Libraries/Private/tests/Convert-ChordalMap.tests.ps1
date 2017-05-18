. ./Libraries/Private/Convert-ChordalMap.ps1
. ./Libraries/Private/GeneralClasses.ps1
. ./Libraries/Private/Get-KeyScale.ps1

$IonianScale = Get-KeyScale -RootKey C -ScaleType 'Major'
describe "Convert-ChordalMap" {
    it "Should create a chordmap from the IonianScale" {
        (Convert-ChordalMap -IonianScale $IonianScale)[0].chord_1 | should be "C-E-G-B-I"
    }
}
