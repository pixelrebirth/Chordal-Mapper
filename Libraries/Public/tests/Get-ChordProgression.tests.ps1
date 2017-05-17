describe "Test" {
    it "should fail" {
        $false | should be $true
    }

    it "should not fail" {
        $true| should be $true
    }
}