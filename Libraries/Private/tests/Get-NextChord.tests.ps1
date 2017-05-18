. ./Libraries/Private/Get-NextChord.ps1
describe "Get-NextChord" {
    it "Should result in a number pattern" {
        Get-NextChord 1 | should BeLike "*-*"
        Get-NextChord 2 | should BeLike "*-*"
        Get-NextChord 3 | should BeLike "*-*"
        Get-NextChord 4 | should BeLike "*-*"
        Get-NextChord 5 | should BeLike "*-*"
        Get-NextChord 6 | should BeLike "*-*"
        Get-NextChord 7 | should BeLike "*-*"
    }
}